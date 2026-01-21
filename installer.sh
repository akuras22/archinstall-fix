#!/bin/bash

set -e

while true; do
    output=$(python -m archinstall 2>&1) || true

    if echo "$output" | grep -q "ModuleNotFoundError"; then
        module=$(echo "$output" | grep -oP "No module named '\K[^']+")
        pkg="python-${module}"

        echo "Fehlendes Modul gefunden: $module"
        echo "Installiere Paket: $pkg"

        pacman -Sy --noconfirm "$pkg" || {
            echo "Paket $pkg nicht gefunden – Abbruch"
            exit 1
        }
    else
        echo "Keine fehlenden Module mehr. Starte archinstall normal."
        python -m archinstall
        break
    fi
done
