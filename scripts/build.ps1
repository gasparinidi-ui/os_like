# Gera a ISO do OSLike no Windows (requer Docker Desktop com backend WSL2).
# Uso (PowerShell, na pasta do projeto):  .\scripts\build.ps1
$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")

docker build -t oslike-builder .
docker run --rm --privileged -v "${PWD}:/build" -v oslike-work:/work oslike-builder
