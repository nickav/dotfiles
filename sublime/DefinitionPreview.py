import sublime
import sublime_plugin
import html
import codecs
import time
import threading

DEBUG = True

def debug(*args):
    if DEBUG:
        print("[DefinitionPreview]", *args)

#
# TODO(nick):
# - de-duplicate function definitions (e.g. C forward declarations)
# - publish the plugin?
# - user config?
#

#
# DONE:
# - limit matches to only files of current file type!
# - figure out some sort of simple code highlighting story
# - better multiline support 
# - fix expand_to_symbol
# - only show function where cursor is inside parens foo(|)
# - filter out the actual function definition (if over it)
# - bold current word within function definition
# - fix cursor on right paren choosing wrong (outer) function: `foo(fun_func(a));`
# - normalize function defintions
#

def get_filtered_symbol_locations(window, view, word, cursor):
    # @Incomplete: filter out locs under cursor!
    #print("cursor: ", view.rowcol(cursor.a))

    syntax_name = view.syntax().name
    return list(filter(lambda it: it.syntax == syntax_name, window.symbol_locations(word, type=sublime.SYMBOL_TYPE_DEFINITION)))

def expand_to_scope(view, point, selector):
    start_index = point.a
    while (start_index > 0):
        scope_name = view.scope_name(start_index)
        if (selector not in scope_name):
            break

        start_index -= 1

    end_index = point.b
    while (end_index < view.size()):
        scope_name = view.scope_name(end_index)
        if (selector not in scope_name):
            break

        end_index += 1

    return sublime.Region(start_index, end_index)

def expand_scope_backwards_until(view, point, selector):
    start_index = point.a
    while (start_index > 0):
        scope_name = view.scope_name(start_index)
        if (selector in scope_name):
            break

        start_index -= 1

    return sublime.Region(start_index, point.b)

def find_matching_brace(text, start_index, braces):
    open_brace = braces[0]
    close_brace = braces[1]

    start_char = text[start_index]
    match_forward = start_char == open_brace
    match_backward = start_char == close_brace

    if not match_forward and not match_backward:
        return -1

    d = 1 if match_forward else -1
    index = start_index + d
    count = 1

    while count > 0 and index > 0 and index < len(text):
        it = text[index]

        if it == open_brace:
            count += d

        if it == close_brace:
            count -= d

        index += d

    return index if count == 0 else -1

def find_nearest_function_parens(text, offset):
    start_index = offset
    end_index   = offset
    scope_depth = 0

    index = start_index
    while (index > 0):
        at = text[index]

        if scope_depth == 0 and at == "(":
            start_index = index
            break

        if at == "(":
            scope_depth += 1
        if at == ")":
            scope_depth -= 1

        index -= 1

    index = end_index
    while (index < len(text)):
        at = text[index]

        if scope_depth == 0 and at == ")":
            end_index = index + 1
            break

        if at == "(":
            scope_depth += 1
        if at == ")":
            scope_depth -= 1

        index += 1

    return start_index, end_index

def expand_to_symbol(view, scope):
    if "meta.struct.c" in view.scope_name(scope.a):
        scope = expand_to_scope(view, scope, "meta.struct.c")

    if "meta.function." in view.scope_name(scope.a) or "meta.function." in view.scope_name(scope.b):
        scope = expand_to_scope(view, scope, "meta.function.parameters")

        # @Hack: for C we don't get the function scope of the function return type
        if "source.c" in view.scope_name(scope.a):
            scope = expand_scope_backwards_until(view, scope, "storage.type.c")

    # @Incomplete: trim scope to non-whitespace

    return scope

def find_subword(scope_name, subword_prefix):
    start_index = scope_name.find(subword_prefix)
    if start_index >= 0:
        end_index = scope_name.find(' ', start_index)
        if end_index >= 0:
            return scope_name[0:end_index]

    return None

def get_word_at(view, cursor):
    word_range = view.word(cursor)
    word = view.substr(word_range)
    return word

def find_latest_scope_sub_name(view, scope_name, subscope):
    start_index = scope_name.rfind(subscope)
    if start_index >= 0:
        end_index = scope_name.find(' ', start_index)
        if end_index >= 0:
            return scope_name[0:end_index]

    return scope_name

def view_from_file(filename, fallback_syntax):
    """
    Return a view that that contains the contents of the provided file name.
    If the file is not aready loaded, it is loaded into a hidden view and that
    is returned instead.
    Can return None if the file is not open and cannot be loaded.
    """
    for window in sublime.windows():
        view = window.find_open_file(filename)
        if view is not None:
            return view

    content = None
    try:
        with codecs.open(filename, 'r', encoding='utf-8') as file:
            content = file.read()
    except:
        pass

    if content:
        view = sublime.active_window().create_output_panel("_hha_tmp", True)
        view.run_command("select_all")
        view.run_command("left_delete")
        view.run_command("append", {"characters": content})
        if fallback_syntax:
            view.assign_syntax(fallback_syntax)
        return view

    return None

def loc_link(loc, content):
    return ("<a href='%s:%d:%d' style='color: inherit; text-decoration: none'>" % (loc.path, loc.row, loc.col)) + content + "</a>"

def highlight_function_argument(html, arg_index):
    if arg_index < 0:
        return html

    start_index = html.find("(")
    if start_index >= 0:
        end_index = start_index
        while arg_index >= 0:
            start_index = end_index
            end_index = html.find(",", end_index+1)
            if end_index < 0:
                end_index = html.find(")", start_index+1)
                if end_index < 0:
                    end_index = start_index

            arg_index -= 1

        if html[start_index] == ",":
            start_index += 1

        html = html[0:start_index] + "<b>" + html[start_index:end_index] + "</b>" + html[end_index:]

    return html

def find_argument_index(text, index):
    si, ei = find_nearest_function_parens(text, index)

    if si == ei:
        return -1

    return text[0:index].count(",")

def normalize_whitespace(html, go_full_bore = False):
    html = html.replace("<br>", " ")
    html = html.replace("&nbsp;", " ")
    html = html.strip(" ")

    if go_full_bore:
        html = html.replace(" ( ", "(")
        html = html.replace(" (", "(")
        html = html.replace(" )", ")")

        if html[-1] == "{":
            html = html[0:-1]

    html = html.strip(" ")
    return html

# NOTE(nick): look in the source location for the word definition
def build_popup_preview_html(view, locs, cursor = None, scope = None):
    window = sublime.active_window()
    result = ""

    relative_cursor = 0
    arg_index = -1
    if cursor is not None and scope is not None:
        relative_cursor = cursor.a - scope.a
        arg_index = find_argument_index(view.substr(scope), relative_cursor)

    for index, loc in enumerate(locs):
        view = view_from_file(loc.path, view.syntax())
        if view:
            p0 = view.text_point(loc.row - 1, 0)
            p1 = view.text_point(loc.row + 0, 0)

            region = sublime.Region(p0, p1)
            symbol_region = expand_to_symbol(view, region)

            html = view.export_to_html(symbol_region, minihtml=True)

            if loc.kind[0] == sublime.KIND_FUNCTION[0]:
                html = highlight_function_argument(normalize_whitespace(html, True), arg_index)

            result += loc_link(loc, html)

            if index < len(locs) - 1:
                result += "<br />"

    result = "<div style='font-size: 0.9rem; padding: 0.25rem;'>" + result + "</div>"
    return result


class DefinitionPreview(sublime_plugin.EventListener):
    popup = None
    timer = None

    def handle_navigation(self, href):
        if len(href) > 0:
            window = sublime.active_window()
            window.open_file(href, sublime.ENCODED_POSITION)

    def maybe_hide_popup(self):
        if self.popup:
            self.popup.close()
            self.popup = None

    def on_activated(self, view):
        pass


    def do_update(self):
        #return

        start = time.time()

        view = self.view
        
        cursor_range = view.sel()[-1]
        if not cursor_range.empty():
            self.maybe_hide_popup()
            return

        #
        # NOTE(nick): we either look at _exactly_ the word the cursor is under
        # or, we try to expand to the outer-most meta.function-call scope possible
        #

        window = sublime.active_window()
        word = get_word_at(view, cursor_range)

        scope_name = view.scope_name(cursor_range.a)

        debug("[do_update] cursor:", cursor_range.a, "scope:", scope_name)

        # NOTE(nick): skip function declarations
        if "entity.name.function." in scope_name:
            self.maybe_hide_popup()
            return

        # NOTE(nick): skip structs
        if "meta.struct." in scope_name:
            self.maybe_hide_popup()
            return

        expanded = None
        scope = None

        if "meta.function-call" in scope_name:
            scope_name = find_latest_scope_sub_name(view, scope_name, "meta.function-call")
            expanded = view.expand_to_scope(cursor_range.a, scope_name)

            # NOTE(nick): limit scope to only the start of the function
            scope = sublime.Region(expanded.a, expanded.b)
            expanded.b = expanded.a

            is_nested = scope_name.count("meta.function-call") > 1
            if is_nested:
                index = scope_name.rfind(' ')
                if index < 0:
                    index = len(scope_name)
                parent_scope = find_latest_scope_sub_name(view, scope_name[0:index], "meta.function-call")

                dummy = expanded
                dummy = view.expand_to_scope(dummy.a, parent_scope)

                offset = cursor_range.a - dummy.a
                text   = view.substr(dummy)

                start_index = -1
                end_index = -1

                if text[offset] == ')':
                    result = find_matching_brace(text, offset, "()")
                    if result >= 0:
                        start_index = result
                        end_index   = offset
                else:
                    start_index, end_index = find_nearest_function_parens(view.substr(dummy), offset)

                inner_range = sublime.Region(dummy.a + start_index, dummy.a + end_index)

                if start_index != end_index:
                    inner_range = sublime.Region(dummy.a + start_index, dummy.a + end_index)

                    total_scope_depth = view.substr(dummy).count("(")
                    scope_depth = view.substr(inner_range).count("(")

                    if total_scope_depth == scope_depth:
                        expanded = view.expand_to_scope(inner_range.a - 1, parent_scope)
                        scope = sublime.Region(expanded.a, expanded.b)
                        expanded.b = expanded.a

            word = get_word_at(view, expanded)

        if word is None or len(word) == 0:
            return

        locs = get_filtered_symbol_locations(window, view, word, cursor_range)
        if len(locs) == 0:
            self.maybe_hide_popup()
            return

        popup_html = build_popup_preview_html(view, locs, cursor_range, scope)

        self.popup = view.show_popup(
            popup_html,
            flags=sublime.COOPERATE_WITH_AUTO_COMPLETE,
            max_width=1280, max_height=400, on_navigate=self.handle_navigation
        )

        end = time.time()
        debug("Took", (end - start) * 1000, "ms")


    def on_selection_modified_async(self, view):
        #return
        
        if self.timer:
            self.timer.cancel()
            self.timer = None

        cursor_range = view.sel()[-1]
        if not cursor_range.empty():
            self.maybe_hide_popup()
            return

        self.view = view
        self.timer = threading.Timer(0.2, self.do_update)
        self.timer.start()
