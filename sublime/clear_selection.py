import sublime, sublime_plugin

class ClearSelectionCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        sel = self.view.sel()
        if len(sel) > 0:
            pt = sel[0].b
            sel.clear()
            sel.add(sublime.Region(pt, pt))