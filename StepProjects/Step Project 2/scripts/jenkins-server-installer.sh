#!/usr/bin/bash
set -euo pipefail

cd "/home/vagrant/jenkins_data"
sudo usermod -aG docker vagrant
sg docker -c "docker compose up -d"
sudo chmod 770 "/home/vagrant/.docker" -R 2>/dev/null || true
sudo chown vagrant:vagrant "/home/vagrant/.docker" -R 2>/dev/null || true