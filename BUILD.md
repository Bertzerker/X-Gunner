# How To Build The Patched Main_MiSTer Binary

Most testers can use the prebuilt binary in this repository:

```sh
Main_MiSTer/binaries/MiSTer-xgunner-startfix-20260904
```

Build from source if you want to review the patch, test against a newer Main_MiSTer revision, or make changes.

## Requirements

Build host:

- Linux or WSL.
- `git`
- `bash`
- `make`
- `wget`
- `tar`
- `sed`
- ARM Linux cross compiler using the `arm-none-linux-gnueabihf` prefix.

The Main_MiSTer tree includes `setup_default_toolchain.sh`, which can download and configure the expected Arm toolchain for a local build shell.

MiSTer test hardware:

- MiSTer FPGA.
- X-GUNNER receiver and gun.
- A way to copy the built `MiSTer` binary to the MiSTer SD card.
- Back up the existing `/media/fat/MiSTer` binary before replacing it.

Python helper scripts:

- See `REQUIREMENTS.txt`.
- No pip install step is needed.

## Patch Base

The included patch was prepared against this Main_MiSTer commit:

```sh
915ca3395aa5a26322007974faa757299a56b856
```

It may still apply to newer Main_MiSTer revisions, but if upstream `input.cpp` or `menu.cpp` changes around the lightgun code, the patch may need a small manual refresh.

## Build Steps

Clone Main_MiSTer:

```sh
git clone https://github.com/MiSTer-devel/Main_MiSTer.git
cd Main_MiSTer
```

Check out the tested base revision:

```sh
git checkout 915ca3395aa5a26322007974faa757299a56b856
```

Apply the X-GUNNER patch from this repository:

```sh
git apply /path/to/X-Gunner/Main_MiSTer/patches/Main_MiSTer-xgunner-lightgun.patch
```

Set up the toolchain if `arm-none-linux-gnueabihf-gcc` is not already on your `PATH`:

```sh
source ./setup_default_toolchain.sh
```

Build:

```sh
make clean
make
```

The built binary will be:

```sh
bin/MiSTer
```

Copy `bin/MiSTer` to the MiSTer SD card as `/media/fat/MiSTer`, then reboot or restart Main_MiSTer.

## Repository Layout

Files are grouped by their MiSTer install location where possible:

- `config/` contains `.CFG` files for `/media/fat/config/`.
- `config/inputs/` contains input `.map` files for `/media/fat/config/inputs/`.
- `Scripts/` contains helper scripts for `/media/fat/Scripts/`.
- `_Console/` contains `.rbf` core files for `/media/fat/_Console/`.
- `Main_MiSTer/binaries/` contains prebuilt Main_MiSTer test binaries.
- `Main_MiSTer/patches/` contains the source patch for Main_MiSTer.
- `LIGHTGUN_CORES.md` lists the included normal and RetroAchievements core profiles.

## Notes

The upstream `build.sh` can build and deploy over the network, but it is meant for a local developer setup. For public testing, the safer path is to build with `make`, copy the binary manually, and keep any local host files or connection details out of commits.

Do not commit private test reports, local host files, SSH keys, API tokens, or full device inventories.
