# Ambiente de build do OSLike (funciona em Linux, macOS e Windows via Docker Desktop).
FROM debian:trixie

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		live-build debootstrap squashfs-tools xorriso \
		grub-pc-bin grub-efi-amd64-bin grub-efi-ia32-bin mtools dosfstools \
		syslinux syslinux-common isolinux \
		ca-certificates rsync \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /build
ENTRYPOINT ["/build/scripts/build-in-container.sh"]
