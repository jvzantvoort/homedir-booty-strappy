#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""setup_git.py - 


Copyright (C) 2023 jvzantvoort

"""

import argparse
import sys
import os
import configparser

__author__ = "jvzantvoort"
__copyright__ = "John van Zantvoort"
__email__ = "john@vanzantvoort.org"
__license__ = "MIT"
__version__ = "1.0.1"

CONFIGFILE = os.path.expanduser("~/.gitconfig")


class GitConfig:
    configfile = CONFIGFILE
    config = configparser.ConfigParser()
    name = None
    email = None

    def read(self):
        try:
            self.config.read_file(open(self.configfile))
        except FileNotFoundError:
            pass

    def alias(self, alias, cmd):
        if not self.config.has_section("alias"):
            self.config.add_section("alias")
        self.config.set("alias", alias, cmd)

    def add_aliasses(self):
        self.alias("co", "checkout")
        self.alias("fp", "fetch -p")
        self.alias("st", "status -s")
        self.alias("url", "config --get remote.origin.url")
        self.alias("root", "rev-parse --show-toplevel")

    def read_user(self):
        if self.config.has_section("user"):
            if self.name is None:
                if self.config.has_option("user", "name"):
                    self.name = self.config["user"]["name"]

            if self.email is None:
                if self.config.has_option("user", "email"):
                    self.email = self.config["user"]["email"]

    def update_user(self):
        if not self.config.has_section("user"):
            self.config.add_section("user")

        if self.name is not None:
            self.config.set("user", "name", self.name)

        if self.email is not None:
            self.config.set("user", "email", self.email)

    def compile(self):
        self.read()
        self.read_user()
        self.update_user()
        self.add_aliasses()

    def writefh(self, fh):
        self.config.write(fh)

    def write(self):
        with open(self.configfile, "w") as fh:
            self.config.write(fh)


def main(args):
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-n",
        "--noexec",
        dest="noexec",
        action="store_true",
        help="Do not write config file",
    )

    parser.add_argument("-u", "--user", dest="user", help="set username")

    parser.add_argument("-m", "--mail", dest="mail", help="set email address")

    options = parser.parse_args(args)

    gitcfg = GitConfig()

    if options.user:
        gitcfg.name = options.user

    if options.mail:
        gitcfg.email = options.mail

    gitcfg.compile()

    if options.noexec:
        gitcfg.writefh(sys.stdout)
    else:
        gitcfg.write()


if __name__ == "__main__":
    main(sys.argv[1:])
