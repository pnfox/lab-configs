import os

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

class ButtonWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="Power Menu")

        hbox = Gtk.Box(spacing=6)
        self.add(hbox)

        powerIcon = Gtk.Image()
        powerIcon.set_from_file("./powerOff.png")
        hbox.pack_start(powerIcon, True, True, 0)

        rebootIcon = Gtk.Image()
        rebootIcon.set_from_file("./reboot.png")
        hbox.pack_start(rebootIcon, True, True, 0)

        suspendIcon = Gtk.Image()
        suspendButton = Gtk.Button()
        suspendIcon.set_from_file("./suspend.png")
        hbox.pack_start(suspendButton, True, True, 0)
        suspendButton.set_image(suspendIcon)
        suspendButton.connect("clicked", self.on_close_clicked)

    def on_shutdown_clicked(self, button):
        os.system("systemctl poweroff")

    def on_reboot_clicked(self, button):
        os.system("systemctl reboot")

    def on_close_clicked(self, button):
        Gtk.main_quit()

win = ButtonWindow()
win.connect("destroy", Gtk.main_quit)
win.fullscreen()
win.show_all()
Gtk.main()
