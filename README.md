# Archinstall Fix 🛠️

When installing Arch Linux using the built-in archinstall installer, the process can fail because required Python dependencies are missing.  
This repository provides a simple shell script that automatically installs all necessary dependencies so archinstall works as expected.

The goal is not elegance. The goal is: make the installer stop breaking and move on with your life.

## Why this exists

On some Arch ISO environments, archinstall crashes due to missing Python modules or broken dependencies.  
Instead of manually debugging the installer every time, this script fixes the environment in one go.

Reliable, fast, and boring — exactly what you want during an OS install.

## What the script does

- Installs all required Python and system dependencies for archinstall
- Runs directly in the Arch ISO live environment
- Eliminates manual dependency hunting
- Makes repeated Arch installs less painful

## Installation & Usage

Boot into the Arch Linux ISO and run:

```bash
git clone https://github.com/akuras22/archinstall-fix && cd ./archinstall-fix && ./installer.sh
```

After the script finishes, start the installer normally:

```
archinstall
```

## Requirements

- Arch Linux ISO  
- Working internet connection  
- Root privileges (default in the live ISO)

## Notes

- This script only affects the live ISO environment  
- Your installed system will not be modified  
- If the Arch ISO changes dependency handling, updates may be required  
- Pull requests and improvements are welcome  

## License

MIT License  
Do whatever you want — just don’t blame this script if you install Arch at 3 a.m. and forget to mount /boot.
