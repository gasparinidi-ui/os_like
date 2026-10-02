#!/bin/sh
# Roda dentro do container: copia a configuração para uma pasta de trabalho e gera a ISO.
set -e

SRC=/build/livebuild
WORK=/work
OUT=/build/out

mkdir -p "$WORK" "$OUT"
rsync -a --delete --exclude cache --exclude chroot --exclude binary "$SRC"/ "$WORK"/

cd "$WORK"
lb clean
rm -f ./*.iso build.log
lb config
lb build || true
cp build.log "$OUT"/ 2>/dev/null || true

# shellcheck disable=SC2012
ISO="$(ls -t "$WORK"/*.iso 2>/dev/null | head -1)"
if [ -z "$ISO" ]; then
	echo "Falha no build: nenhuma ISO gerada. Veja out/build.log" >&2
	exit 1
fi
cp "$ISO" "$OUT"/
(cd "$OUT" && sha256sum "$(basename "$ISO")" > "$(basename "$ISO").sha256")
echo "ISO gerada: out/$(basename "$ISO")"
