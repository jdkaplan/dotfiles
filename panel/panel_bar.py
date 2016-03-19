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

PANEL_FOREGROUND='#FF888888'
PANEL_BACKGROUND='#FF111111'

COLOR_FOCUSED_FG = '#FFE0E0E0'
COLOR_OCCUPIED_FG = '#FFA3A6AB'
COLOR_URGENT_BG = '#FF34322E'

DIVIDER = ' | '


def color_string(string, fg=PANEL_FOREGROUND, bg=PANEL_BACKGROUND):
    return "%%{F%s}%%{B%s} %s %%{B-}%%{F-}" % (fg, bg, string)


def status_update(data):
    # monitor, occupied, free, urgent (with uppercase meaning focused)
    colors = {
        'm': None,
        'M': None,
        'o': {},
        'O': {'fg': COLOR_FOCUSED_FG},
        'f': None,
        'F': {'fg': COLOR_FOCUSED_FG},
        'u': {'bg': COLOR_URGENT_BG},
        'U': {'fg': COLOR_FOCUSED_FG, 'bg': COLOR_URGENT_BG},
        'L': None,              # focused desktop layout
        'T': None,              # focused node state
        'G': None,              # focused node active flags
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
            wm_info += color_string(name, **color)
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
    bspc_control = subprocess.Popen(["bspc", "subscribe"],
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
