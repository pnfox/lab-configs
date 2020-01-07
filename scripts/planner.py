import time
import os
import sys

def help():
    print("============================")
    print("= Planner Application      =")
    print("=                          =")
    print("= Usage:                   =")
    print("=    python planner.py \   =")
    print("=       [taskname] [time]  =")
    print("============================")

if(len(sys.argv) != 3):
    help()
    exit()

taskName = str(sys.argv[1])
taskTime = float(sys.argv[2])
taskTimeSeconds = taskTime * 60

start = time.time()
try:
    time.sleep(taskTimeSeconds)
except KeyboardInterrupt:
    finish = time.time()
    taskTime = int((finish - start) / 60.)

f = open("workDoneToday.txt", "a+")
f.write(time.strftime("%d %b %Y: %H:%M  ", time.gmtime()) + \
            taskName + " for " + str(taskTime) + " min\n")
f.close()

os.execv('/bin/notify-send', ['foo', '-i', '/usr/share/icons/Papirus/32x32/status/task-due.svg', taskName+" timer done"])

