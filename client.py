#!/usr/bin/env python3
import sys
import telnetlib


def main():
    try:
        _, host, port = sys.argv
    except ValueError:
        return print('WRONG FORMAT. USAGE: ./client.py <HOST> <PORT>')

    with telnetlib.Telnet(host, port) as tn:
        print('CONNECTED')
        tn.interact()


main()
