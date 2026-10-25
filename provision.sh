#!/usr/bin/env bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

if ! command -v docker >/dev/null 2>&1; then
  echo "==> Instalando Docker Engine y Compose (repositorio oficial)..."
  apt-get update -y
  apt-get install -y ca-certificates curl gnupg
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
    > /etc/apt/sources.list.d/docker.list
  apt-get update -y
  apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

systemctl enable --now docker
usermod -aG docker vagrant

cd /vagrant

if [ ! -f .env ]; then
  echo "==> No hay .env: se crea a partir de .env.example (cambia las contraseñas)."
  cp .env.example .env
fi

echo "==> Levantando contenedores..."
docker compose up -d

echo "==> Listo. Abre http://localhost:8080 (la instalación de WordPress tarda ~1 minuto)."
echo "    Progreso: vagrant ssh -c 'cd /vagrant && docker compose logs -f wpcli'"
