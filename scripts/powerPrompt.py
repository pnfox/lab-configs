import os

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

class ButtonWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="Power Menu")

        self.fullscreen()

        hbox = Gtk.ButtonBox()
        self.add(hbox)

        hbox.padding = 200

        powerIcon = Gtk.Image()
        powerButton = Gtk.Button()
        powerIcon.set_from_file("./powerOff.png")
        #powerButton.set_size_request(250, 250)
        hbox.pack_start(powerButton, True, True, 0)
        powerButton.set_image(powerIcon)

        rebootIcon = Gtk.Image()
        rebootButton = Gtk.Button()
        #rebootButton.set_size_request(250,250)
        rebootIcon.set_from_file("./reboot.png")
        hbox.pack_start(rebootButton, True, True, 0)
        rebootButton.set_image(rebootIcon)

        suspendIcon = Gtk.Image()
        suspendButton = Gtk.Button()
        #suspendButton.set_size_request(250, 250)
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
win.show_all()
Gtk.main()
