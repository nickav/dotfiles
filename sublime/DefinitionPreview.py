import sublime
import sublime_plugin
import html
import codecs

#
# TODO(nick):
# - filter out the actual function definition (if over it)
# - better multiline support / read_entire_symbol_definition (for functions and structs at least to start)
# - bold current word within function definition
#

#
# DONE:
# - limit matches to only files of current file type!
# - figure out some sort of simple code highlighting story
#

def get_filtered_symbol_locations(window, view, word):
    # @Incomplete: filter out locs under cursor!
    syntax_name = view.syntax().name
    return list(filter(lambda it: it.syntax == syntax_name, window.symbol_locations(word, type=sublime.SYMBOL_TYPE_DEFINITION)))


def find_nearest_symbol(view, cursor):
    window = sublime.active_window()

    word_range = view.word(cursor)
    line_range = view.line(cursor)

    # NOTE(nick): preview symbol under word??
    word = view.substr(word_range)
    locs = get_filtered_symbol_locations(window, view, word)

    # NOTE(nick): filter only for "struct" definitions
    locs = list(filter(lambda it: it.kind[2] == 'Type', locs))
    if len(locs) > 0:
        return word, locs

    word = None
    line = view.substr(line_range)

    paren_count = 0
    index = cursor.a - 1
    while ((index - line_range.a) > 0):
        at = line[index - line_range.a]

        if at == ")":
            paren_count -= 1

        if at == "(":
            paren_count += 1

        if paren_count == 1:
            break
            
        index -= 1

    if (index - line_range.a) > 0:
        word_range = view.word(sublime.Region(index - 2, index - 2))
        word = view.substr(word_range)
        print("function found: ", index - line_range.a, word)
        locs = get_filtered_symbol_locations(window, view, word)

    return word, locs

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

def build_popup_preview_html(view, word, locs):
    window = sublime.active_window()
    result = ""

    for index, loc in enumerate(locs):
        view = view_from_file(loc.path, view.syntax())
        if view:
            p0 = view.text_point(loc.row - 1, 0)
            p1 = view.text_point(loc.row + 0, 0)
            result += loc_link(loc, view.export_to_html(sublime.Region(p0, p1), minihtml=True))

            if index < len(locs) - 1:
                result += "<br />"

        #it = "Hello, world!!!!!!"
        #result += "<div>" + ("<a href='%s:%d:%d' style='text-decoration: none'>" % (loc.path, loc.row, loc.col)) + html.escape(it) + "</a>" + "</div>"

    result = "<div style='font-size: 0.9rem;'>" + result + "</div>"
    return result


class DefinitionPreview(sublime_plugin.EventListener):
    popup = None

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

    def on_selection_modified_async(self, view):
        #if view.is_auto_complete_visible():
        #    self.maybe_hide_popup()
        #    return

        cursor_range = view.sel()[-1]
        if not cursor_range.empty():
            self.maybe_hide_popup()
            return

        word, locs = find_nearest_symbol(view, cursor_range)
        if len(locs) == 0:
            self.maybe_hide_popup()
            return

        popup_html = build_popup_preview_html(view, word, locs)

        self.popup = view.show_popup(
            popup_html,
            flags=sublime.COOPERATE_WITH_AUTO_COMPLETE,
            max_width=1280, max_height=400, on_navigate=self.handle_navigation
        )
