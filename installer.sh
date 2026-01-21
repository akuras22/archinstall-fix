#!/bin/bash

set -e

pacman -Sy --noconfirm python archinstall pkgfile
pkgfile --update

while true; do
    output=$(python -m archinstall 2>&1) || true

    if echo "$output" | grep -q "ModuleNotFoundError"; then
        module=$(echo "$output" | grep -oP "No module named '\K[^']+")

        echo "Missing Python module: $module"
        pkg=$(pkgfile -s "/usr/lib/python*/site-packages/${module}" | head -n1 | cut -d/ -f1)

        if [ -z "$pkg" ]; then
            echo "No Arch package provides module '$module'"
            exit 1
        fi

        echo "Installing package: $pkg"
        pacman -Sy --noconfirm "$pkg"
    else
        python -m archinstall
        break
    fi
done
