import os

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

class ButtonWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="Power Menu")
        self.set_border_width(10)

        hbox = Gtk.Box(spacing=6)
        self.add(hbox)

        button = Gtk.Button.new_with_label("Shutdown")
        button.connect("clicked", self.on_shutdown_clicked)
        hbox.pack_start(button, True, True, 0)

        button = Gtk.Button.new_with_label("Reboot")
        button.connect("clicked", self.on_reboot_clicked)
        hbox.pack_start(button, True, True, 0)

        button = Gtk.Button.new_with_mnemonic("_Close")
        button.connect("clicked", self.on_close_clicked)
        hbox.pack_start(button, True, True, 0)

    def on_shutdown_clicked(self, button):
        os.system("systemctl poweroff")

    def on_reboot_clicked(self, button):
        os.system("systemctl reboot")

    def on_close_clicked(self, button):
        Gtk.main_quit()

win = ButtonWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()
