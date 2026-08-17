#!/bin/bash
# Adds the Razer Blade 14 (2023, USB PID 0x02C5) to the `razercontrol` DKMS
# driver's supported-device table, then rebuilds/reinstalls the module and
# restarts the daemon.
#
# Needed because razer-laptop-control-dkms-git's device table doesn't include
# this laptop's USB product ID, so the stock module never binds to its
# keyboard and razerdaemon.service panics with "Sysfs ready! ... unwrap() on
# a None value". See driver/src/defines.h upstream:
# https://github.com/rnd-ash/razer-laptop-control
#
# Re-run needed after every razer-laptop-control-dkms-git update/rebuild,
# since that -git package re-pulls pristine upstream source into /usr/src,
# wiping this patch. Installed as a pacman hook (see
# config/pacman/hooks/95-razer-blade-14-patch.hook) so it reapplies
# automatically.
#
# Run as root: sudo bash razer-blade-14-patch.sh
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo: sudo bash $0" >&2
  exit 1
fi

SRC=$(find /usr/src -maxdepth 1 -type d -name 'razercontrol-*' | sort -V | tail -n1)
if [[ -z $SRC ]]; then
  echo "No /usr/src/razercontrol-* found - is razer-laptop-control-dkms-git installed?" >&2
  exit 1
fi
DKMS_VERSION=$(basename "$SRC" | sed 's/^razercontrol-//')
DEFINES="$SRC/src/defines.h"
COMMON="$SRC/src/razer_common.c"

# Restore point: pristine copies saved once, before any edit.
[[ -f "$DEFINES.orig" ]] || cp "$DEFINES" "$DEFINES.orig"
[[ -f "$COMMON.orig" ]] || cp "$COMMON" "$COMMON.orig"

if grep -q "BLADE_14_2023" "$DEFINES"; then
  echo "Already patched (BLADE_14_2023 found in defines.h)."
else
  sed -i 's/#define BLADE_14_2021 0x0270/#define BLADE_14_2021 0x0270\n#define BLADE_14_2023 0x02C5/' "$DEFINES"
  echo "Patched $DEFINES"
fi

if grep -q "BLADE_14_2023" "$COMMON"; then
  echo "Already patched (BLADE_14_2023 found in razer_common.c)."
else
  sed -i 's/{ HID_USB_DEVICE(RAZER_VENDOR_ID, BLADE_14_2021)},/{ HID_USB_DEVICE(RAZER_VENDOR_ID, BLADE_14_2021)},\n        { HID_USB_DEVICE(RAZER_VENDOR_ID, BLADE_14_2023)},/' "$COMMON"
  echo "Patched $COMMON"
fi

echo "Rebuilding DKMS module ($DKMS_VERSION)..."
dkms remove "razercontrol/$DKMS_VERSION" --all 2>/dev/null || true
dkms install "razercontrol/$DKMS_VERSION"

echo "Reloading kernel module..."
modprobe -r razercontrol || true
modprobe razercontrol

echo "Restarting daemon..."
systemctl restart razerdaemon.service
sleep 1
systemctl status razerdaemon.service --no-pager || true

echo
echo "Done. Verify with: razer-cli --help  (or check 'journalctl -u razerdaemon -n 20')"
