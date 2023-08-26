#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""setup_dirs.py - setup homedir dirs"""

import os

__author__ = "jvzantvoort"
__copyright__ = "John van Zantvoort"
__email__ = "john@vanzantvoort.org"
__license__ = "MIT"

DIRECTORIES = [
    ("~/.cache", 0o700),
    ("~/.config", 0o755),
    ("~/.gnupg", 0o700),
    ("~/.local", 0o775),
    ("~/.mozilla", 0o755),
    ("~/.ssh", 0o700),
    ("~/Archive", 0o755),
    ("~/Desktop", 0o755),
    ("~/Documents", 0o755),
    ("~/Downloads", 0o755),
    ("~/Music", 0o755),
    ("~/Notes", 0o755),
    ("~/Pictures", 0o755),
    ("~/Projects", 0o755),
    ("~/Public", 0o755),
    ("~/Templates", 0o755),
    ("~/Videos", 0o755),
    ("~/Workspace", 0o755),
    ("~/Writing", 0o775),
    ("~/bin", 0o755),
    ("~/tmp", 0o755),
]

for directory, perms in DIRECTORIES:
    path = os.path.expanduser(directory)
    try:
        os.makedirs(path)
    except OSError:
        pass
    os.chmod(path, perms)


