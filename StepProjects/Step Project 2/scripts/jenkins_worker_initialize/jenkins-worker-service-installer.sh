#!/usr/bin/bash
set -euo pipefail

JENKINS_SERVER=$1
JENKINS_SECRET=$2
JENKINS_AGENT_ID=$3
JENKINS_FOLDER="/home/vagrant/jenkins"

mkdir -p "${JENKINS_FOLDER}"
curl -so /home/vagrant/jenkins/agent.jar "${JENKINS_SERVER}/jnlpJars/agent.jar"
sudo chown "vagrant:vagrant" "${JENKINS_FOLDER}" -R
sudo chmod 750 "${JENKINS_FOLDER}" -R

sudo tee /etc/systemd/system/jenkins-worker.service <<EOF
[Unit]
Description=Jenkins Worker Agent
After=network.target docker.target

[Service]
Type=simple
User=vagrant
Group=docker
WorkingDirectory=/home/vagrant
Environment="JENKINS_URL=${JENKINS_SERVER}"
Environment="JENKINS_SECRET=${JENKINS_SECRET}"
Environment="JENKINS_AGENT_NAME=${JENKINS_AGENT_ID}"
ExecStartPre=/bin/bash -c 'while ! nc -z 10.0.0.2 8080; do sleep 1; done'
ExecStart=/usr/bin/java -jar /home/vagrant/jenkins/agent.jar -url \${JENKINS_URL} -secret \${>
Restart=always
RestartSec=10
StandardOutput=append:/var/log/jenkins-worker.log
StandardError=append:/var/log/jenkins-worker.log

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable jenkins-worker
sudo systemctl start jenkins-worker

sudo systemctl status jenkins-worker --no-pager
