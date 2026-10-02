#!/bin/sh
# Testa a ISO numa máquina virtual (UEFI se o OVMF estiver instalado).
# Uso: ./scripts/run-qemu.sh [caminho/para/oslike.iso]
set -e
cd "$(dirname "$0")/.."

# shellcheck disable=SC2012
ISO="${1:-$(ls -t out/*.iso | head -1)}"
OVMF=/usr/share/ovmf/OVMF.fd

set -- -m 4G -smp 2 -cdrom "$ISO" -boot d -vga virtio -display gtk -usb -device usb-tablet
[ -e /dev/kvm ] && set -- "$@" -enable-kvm -cpu host
[ -f "$OVMF" ] && set -- "$@" -bios "$OVMF"

exec qemu-system-x86_64 "$@"
