#!/bin/sh
# Personaliza os menus de boot (GRUB para UEFI, ISOLINUX para BIOS) a partir
# dos modelos do live-build: fundo do OSLike e início automático em 5 segundos.
# Uso: customize-bootloaders.sh <pasta-de-trabalho-do-live-build> <pasta-artwork>
set -e

WORK="$1"
ART="$2"
DEST="$WORK/config/bootloaders"

rm -rf "$DEST"
cp -r /usr/share/live/build/bootloaders "$DEST"

echo "== Modelos de boot (antes) =="
find "$DEST" -type f | sort
grep -rniE 'timeout|splash|title' "$DEST" --include='*.cfg' --include='*.txt' || true

# Fundo
find "$DEST" -name 'splash.svg' -exec cp "$ART/boot-splash.svg" {} \;
find "$DEST" -name 'splash.png' -exec cp "$ART/boot-splash.png" {} \;

# GRUB: troca qualquer timeout existente; se não houver, define um
GRUB_CFGS="$(find "$DEST/grub-pc" -name '*.cfg' 2>/dev/null || true)"
if [ -n "$GRUB_CFGS" ]; then
	# shellcheck disable=SC2086
	sed -i -E 's/^([[:space:]]*set[[:space:]]+timeout=).*/\15/' $GRUB_CFGS
	# shellcheck disable=SC2086
	if ! grep -qE '^[[:space:]]*set[[:space:]]+timeout=' $GRUB_CFGS; then
		printf '\nset timeout=5\nset timeout_style=menu\n' >> "$DEST/grub-pc/config.cfg"
	fi
fi

# ISOLINUX/SYSLINUX: timeout em décimos de segundo
find "$DEST" -path '*linux*' -name '*.cfg' -exec sed -i -E 's/^([[:space:]]*timeout[[:space:]]+).*/\150/I' {} \;

echo "== Modelos de boot (depois) =="
grep -rniE 'timeout' "$DEST" --include='*.cfg' || true
