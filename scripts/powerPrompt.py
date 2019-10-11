import os

import cairo
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

def draw(da, ctx):

    ctx.set_source_rgb(0,0,0)
    ctx.set_line_width(20 / 4)
    #ctx.set_tolerance(0.1)

    # Drawing shapes
    ctx.save()
    ctx.new_path()

    ctx.rectangle(0,0,40,40)

    ctx.close_path()

    ctx.stroke()

    ctx.restore()

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

        drawingArea = Gtk.DrawingArea()
        hbox.pack_start(drawingArea, True, True, 0)
        drawingArea.connect('draw', draw)

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
