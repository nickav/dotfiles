import sublime
import sublime_plugin


def _hide_menu(window):
    if window is not None and window.is_menu_visible():
        window.set_menu_visible(False)


class HideMenuListener(sublime_plugin.EventListener):
    def on_init(self, views):
        for window in sublime.windows():
            _hide_menu(window)

    def on_new_window_async(self, window):
        _hide_menu(window)

    def on_activated_async(self, view):
        _hide_menu(view.window())
