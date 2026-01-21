#!/bin/bash

set -e

echo "==> Synchronisiere Paketdatenbank"
pacman -Sy --noconfirm

echo "==> Installiere archinstall + alle benötigten Python-Module"

pacman -S --noconfirm \
  archinstall \
  python \
  python-pydantic \
  python-pydantic-core \
  python-jsonschema \
  python-typing_extensions \
  python-rich \
  python-jinja \
  python-yaml \
  python-requests \
  python-setuptools \
  python-packaging \
  python-psutil \
  python-attrs \
  python-more-itertools \
  python-platformdirs \
  python-dateutil \
  python-pyxdg \
  python-charset-normalizer \
  python-idna \
  python-urllib3 \
  python-certifi \
  python-filelock \
  python-colorama \
  python-termcolor \
  python-click \
  python-zipp \
  python-importlib-metadata \
  python-importlib-resources

echo "==> Fertig. Starte archinstall."
python -m archinstall
