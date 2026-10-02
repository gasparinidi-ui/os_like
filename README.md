# OSLike

Sistema operacional baseado em Linux (**Debian 13 "trixie"**) com ambiente gráfico
**KDE Plasma 6** configurado para ficar parecido com o Windows.

## O que vem pronto

| Windows                      | OSLike                                      |
|------------------------------|---------------------------------------------|
| Barra de tarefas embaixo     | Painel inferior fixo com ícones de programas |
| Botão Iniciar / tecla Win    | Menu de aplicativos (Kickoff) com busca      |
| Bandeja, relógio e data      | Bandeja do sistema + relógio com data        |
| "Mostrar área de trabalho"   | Botão no canto direito da barra              |
| Ícones na área de trabalho   | Este Computador, Meus Arquivos, Lixeira, Firefox |
| Clique duplo para abrir      | Clique duplo (padrão do KDE é clique único)  |
| Botões _ □ X à direita       | Minimizar, maximizar e fechar à direita      |
| Explorador de Arquivos       | Dolphin                                      |
| Edge                         | Firefox ESR                                  |
| Microsoft Office             | LibreOffice (Writer, Calc, Impress)          |
| Microsoft Store              | Discover (+ Flatpak/Flathub)                 |
| Prompt de Comando            | Konsole                                     |
| Instalador do Windows        | Calamares (instalador gráfico)               |

Também já vem em **português do Brasil**, com teclado **ABNT2** e fuso **America/Sao_Paulo**.

## Estrutura do projeto

```
livebuild/                     configuração do live-build (gerador de ISO do Debian)
  auto/config                  opções da ISO (versão do Debian, boot, idioma…)
  config/package-lists/        pacotes instalados no sistema
  config/hooks/normal/         scripts executados dentro do sistema durante o build
  config/includes.chroot/      arquivos copiados para o sistema
    usr/share/plasma/look-and-feel/org.oslike.desktop/   layout estilo Windows
    usr/share/wallpapers/OSLike/                          papel de parede
    usr/local/bin/oslike-firstrun                         ícones da área de trabalho
    etc/xdg/                                              padrões do KDE
artwork/                       arquivos-fonte das imagens (SVG)
scripts/                       build e teste
Dockerfile                     ambiente de build
```

## Como gerar a ISO

### Opção 1 — GitHub Actions (mais fácil, não precisa instalar nada)

1. No GitHub, abra **Actions → Build ISO → Run workflow**.
2. Aguarde (~30–60 min) e baixe o artefato **oslike-iso**.

### Opção 2 — No Windows (Docker Desktop)

Requisitos: [Docker Desktop](https://www.docker.com/products/docker-desktop/) com WSL2
e ~25 GB livres.

```powershell
git clone https://github.com/gasparinidi-ui/os_like.git D:\OS_LIKE_Linux
cd D:\OS_LIKE_Linux
.\scripts\build.ps1
```

A ISO aparece em `D:\OS_LIKE_Linux\out\`.

### Opção 3 — No Linux

```sh
./scripts/build.sh            # gera out/oslike-amd64.hybrid.iso
./scripts/run-qemu.sh         # testa numa VM (precisa do qemu-system-x86)
```

## Testar e instalar

- **VirtualBox / VMware / Hyper-V**: crie uma VM Linux 64-bit (Debian), 4 GB RAM,
  2 CPUs, 30 GB de disco e use a ISO como CD. No VirtualBox, ative EFI e use a
  placa de vídeo VMSVGA.
- **Pendrive**: grave a ISO com [Rufus](https://rufus.ie) (modo *DD*) ou
  [balenaEtcher](https://etcher.balena.io).
- O sistema inicia em modo **live** (usuário `oslike`, login automático).
  Para instalar no disco, clique em **Instalar OSLike** na área de trabalho.

## Personalizar

- **Programas**: edite `livebuild/config/package-lists/oslike.list.chroot`
  (nomes de pacotes do Debian — busque em https://packages.debian.org/trixie/).
- **Barra de tarefas / menu Iniciar**: edite
  `.../look-and-feel/org.oslike.desktop/contents/layouts/org.kde.plasma.desktop-layout.js`.
  Para a barra centralizada estilo Windows 11, adicione um
  `panel.addWidget("org.kde.plasma.panelspacer")` antes do Kickoff e outro
  depois do `icontasks`.
- **Tema / cores**: `.../org.oslike.desktop/contents/defaults` e `etc/xdg/kdeglobals`.
- **Papel de parede**: substitua
  `livebuild/config/includes.chroot/usr/share/wallpapers/OSLike/contents/images/1920x1080.png`.

## Próximos passos sugeridos

- Branding próprio no instalador Calamares (logo e textos).
- Tema de boot (Plymouth) e tela de login (SDDM) personalizados.
- Wine/Bottles para rodar programas do Windows.
- Repositório APT próprio para atualizações do OSLike.
