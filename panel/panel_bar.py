#!/usr/bin/python3 -u
import subprocess
import os
import select
import sys
import fcntl
import time
import datetime
import socket

PERIOD = 1
# Lemonbar seems to struggle if you update too fast
MIN_UPDATE_INTERVAL = 0.01
PATH = os.path.dirname(os.path.realpath(__file__))
COLOR_ACTIVE_MONITOR_FG = '#FF34322E'
COLOR_ACTIVE_MONITOR_BG = '#FF58C5F1'
COLOR_INACTIVE_MONITOR_FG = '#FF58C5F1'
COLOR_INACTIVE_MONITOR_BG = '#FF34322E'
COLOR_FOCUSED_OCCUPIED_FG = '#FFF6F9FF'
COLOR_FOCUSED_OCCUPIED_BG = '#FF5C5955'
COLOR_FOCUSED_FREE_FG = '#FFF6F9FF'
COLOR_FOCUSED_FREE_BG = '#FF6D561C'
COLOR_FOCUSED_URGENT_FG = '#FF34322E'
COLOR_FOCUSED_URGENT_BG = '#FFF9A299'
COLOR_OCCUPIED_FG = '#FFA3A6AB'
COLOR_OCCUPIED_BG = '#FF34322E'
COLOR_FREE_FG = '#FF6F7277'
COLOR_FREE_BG = '#FF34322E'
COLOR_URGENT_FG = '#FFF9A299'
COLOR_URGENT_BG = '#FF34322E'
COLOR_LAYOUT_FG = '#FFA3A6AB'
COLOR_LAYOUT_BG = '#FF34322E'
COLOR_STATUS_FG = '#FFA3A6AB'
COLOR_STATUS_BG = '#FF34322E'
DIVIDER = ' | '


def color_string(string, fg=COLOR_STATUS_FG, bg=COLOR_STATUS_BG):
    return "%%{F%s}%%{B%s} %s %%{B-}%%{F-}" % (fg, bg, string)


def status_update(data):
    colors = {
        'M': None,  # (COLOR_ACTIVE_MONITOR_FG, COLOR_ACTIVE_MONITOR_BG),
        'm': (COLOR_INACTIVE_MONITOR_FG, COLOR_INACTIVE_MONITOR_BG),
        'O': (COLOR_FOCUSED_OCCUPIED_FG, COLOR_FOCUSED_OCCUPIED_BG),
        'F': (COLOR_FOCUSED_FREE_FG, COLOR_FOCUSED_FREE_BG),
        'U': (COLOR_FOCUSED_URGENT_FG, COLOR_FOCUSED_URGENT_BG),
        'o': (COLOR_OCCUPIED_FG, COLOR_OCCUPIED_BG),
        'f': None,  # (COLOR_FREE_FG, COLOR_FREE_BG),
        'u': (COLOR_URGENT_FG, COLOR_URGENT_BG),
        'L': None,  # (COLOR_LAYOUT_FG, COLOR_LAYOUT_BG),
    }
    data = data.decode('utf-8')
    assert data[0] == 'W'
    data = data[1:-1]
    data = data.split(':')
    wm_info = ""
    for item in data:
        if len(item) == 0:
            continue
        color = colors[item[0]]
        if color is not None:
            name = item[1:]
            wm_info += color_string(name, *color)
    return 'status', wm_info


def clock_update(_):
    clock = time.strftime("%a %d %b %H:%M:%S")
    return 'clock', color_string(clock)


def volume_update(_):
    info = subprocess.check_output(['pulseaudio-ctl', 'full-status'])
    info = info[:-1].decode('utf-8')
    volume, muted, _ = info.split(' ')
    volume = int(volume)
    muted = "-" if muted == "yes" else "%%"
    return 'volume', color_string("Vol: %d%s" % (volume, muted))

def wifi_update(_):
    info = subprocess.check_output(['netctl-auto', 'current'])
    info = info[:-1].decode('utf-8')
    if info:
        interface, network = info.split('-', 1)
    else:
        interface, network = 'wlp2s0', '-'
    return 'wifi', color_string('{}: {}'.format(interface, network))


def battery_update(_):
    info = subprocess.check_output(['acpi', '--battery'])
    info = info[:-1].decode('utf-8')
    _, status = info.split(': ')
    state, charge, *_ = status.split(', ')
    state = state
    charge = int(charge[:-1])
    return 'battery', color_string("%s %d%%%%" % (state, charge))


def make_string(status, clock, volume, battery, wifi):
    print("%%{1}%s%%{c}%%{r}%s%s%s%s%s%s%s" %
          (status, wifi, DIVIDER, battery, DIVIDER, volume, DIVIDER, clock))


def open_socket(address):
    try:
        os.unlink(address)
    except OSError:
        if os.path.exists(address):
            raise
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock.bind(address)
    sock.listen(1)
    return sock


def main(argv):
    state_strings = {
        'status': "",
        'battery': battery_update(None)[1],
        'volume': volume_update(None)[1],
        'clock': clock_update(None)[1],
    }
    # These processes trigger when events happen.
    bspc_control = subprocess.Popen(["bspc", "control", "--subscribe"],
                                    stdout=subprocess.PIPE)
    listening = [bspc_control]
    # Make stdout nonblocking.
    # Sometimes select says there's output, but read fails.
    # This makes it possible to handle those cases graciously.
    for l in listening:
        fd = l.stdout.fileno()
        fl = fcntl.fcntl(fd, fcntl.F_GETFL)
        fcntl.fcntl(fd, fcntl.F_SETFL, fl | os.O_NONBLOCK)
    read_list = [l.stdout for l in listening]

    # These sockets trigger when events happen
    socks = []
    read_list.extend(socks)

    previous_update = 0
    now = datetime.datetime.now()
    timeout = PERIOD-(now.second % PERIOD)
    file_to_fns = {
        bspc_control.stdout: status_update,
        # volume_sock: volume_update,
    }
    while True:
        to_read, _, _ = select.select(read_list, [], [], timeout)
        for r in to_read:
            if r in socks:
                connection, _ = r.accept()
                data = connection.recv(1024)
                connection.close()
            else:
                try:
                    data = r.readline()
                except OSError:
                    # Some weird cases might get you here
                    continue
                if (data == b''):
                    print("One of our scripts died?", file=sys.stderr)
                    return 1
            state_type, result = file_to_fns[r](data)
            state_strings[state_type] = result

        state_strings['wifi'] = wifi_update(None)[1]
        state_strings['clock'] = clock_update(None)[1]
        state_strings['volume'] = volume_update(None)[1]
        state_strings['battery'] = battery_update(None)[1]
        if time.time() - previous_update < MIN_UPDATE_INTERVAL:
            timeout = MIN_UPDATE_INTERVAL - (time.time()-previous_update)
        else:
            make_string(**state_strings)
            previous_update = time.time()
            now = datetime.datetime.now()
            period_timeout = PERIOD-(now.second % PERIOD)
            timeout = max(period_timeout, MIN_UPDATE_INTERVAL)

if __name__ == "__main__":
    sys.exit(main(sys.argv))
