#!/bin/bash

set -e

echo "==> Preparing disk-backed pacman cache"

# Ensure target mount exists
mkdir -p /mnt

# Create cache directory on disk
mkdir -p /mnt/var/cache/pacman/pkg

# Clean tmpfs cache before bind-mount
rm -rf /var/cache/pacman/pkg/* || true

# Bind mount disk cache over tmpfs cache
mount --bind /mnt/var/cache/pacman/pkg /var/cache/pacman/pkg

echo "==> Installing required base tools"
pacman -Sy --noconfirm python archinstall pkgfile

echo "==> Updating pkgfile database"
pkgfile --update

echo "==> Starting archinstall dependency resolver loop"

while true; do
    output=$(python -m archinstall 2>&1) || true

    if echo "$output" | grep -q "ModuleNotFoundError"; then
        module=$(echo "$output" | grep -oP "No module named '\K[^']+")

        echo "Missing Python module: $module"

        pkg=$(pkgfile -s "/usr/lib/python*/site-packages/${module}" \
              | head -n1 \
              | cut -d/ -f1)

        if [ -z "$pkg" ]; then
            echo "ERROR: No Arch package provides Python module '$module'"
            exit 1
        fi

        echo "Installing Arch package: $pkg"
        pacman -Sy --noconfirm "$pkg"
    else
        echo "All Python modules resolved. Launching archinstall."
        python -m archinstall
        break
    fi
done
