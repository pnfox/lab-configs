import os

import cairo
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

def draw(da, ctx):

    ctx.set_source_rgb(0,0,0)
    ctx.set_line_width(20 / 4)

    # Drawing shapes
    ctx.save()
    ctx.new_path()

    ctx.arc(300, 300, 40, 0, 2*3.14159)
    ctx.rectangle(300,300,0,40)

    ctx.close_path()

    ctx.stroke()

    ctx.restore()

class ButtonWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="Power Menu")
        self.set_border_width(10)

        hbox = Gtk.Box(spacing=6)
        self.add(hbox)

        #button = Gtk.Button.new_with_label("Shutdown")
        #button.connect("clicked", self.on_shutdown_clicked)
        #hbox.pack_start(button, True, True, 0)

        #button = Gtk.Button.new_with_label("Reboot")
        #button.connect("clicked", self.on_reboot_clicked)
        #hbox.pack_start(button, True, True, 0)

        #button = Gtk.Button.new_with_mnemonic("_Close")
        #button.connect("clicked", self.on_close_clicked)
        #hbox.pack_start(button, True, True, 0)

        powerIcon = Gtk.Image()
        powerIcon.set_from_file("./powerOff.png")
        hbox.pack_start(powerIcon, True, True, 0)

        powerIcon = Gtk.Image()
        powerIcon.set_from_file("./reboot.png")
        hbox.pack_start(powerIcon, True, True, 0)
        powerIcon = Gtk.Image()
        powerIcon.set_from_file("./suspend.png")
        hbox.pack_start(powerIcon, True, True, 0)
        
        drawingArea = Gtk.DrawingArea()
        drawingArea.connect('draw', draw)
        drawingArea.connect("button-press-event", self.on_close_clicked)

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
