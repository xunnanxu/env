#!/usr/bin/env bash

# Check if Vim has Python 3 support
vim --version | grep -q "+python3" && echo "Vim has Python 3 support" || (echo "Assertion failed: Vim does not have Python 3 support" && exit 1)

vi -c "PlugInstall" -c "q!" -c "q!" && echo "Vim setup complete"
