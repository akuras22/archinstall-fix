#!/bin/bash

set -e

pacman -Sy --noconfirm python archinstall

while true; do
    output=$(python -m archinstall 2>&1) || true

    if echo "$output" | grep -q "ModuleNotFoundError"; then
        module=$(echo "$output" | grep -oP "No module named '\K[^']+")
        pkg="python-${module}"

        echo "Installing missing module: $pkg"
        pacman -Sy --noconfirm "$pkg" || {
            echo "Cannot resolve module $module"
            exit 1
        }
    else
        python -m archinstall
        break
    fi
done
