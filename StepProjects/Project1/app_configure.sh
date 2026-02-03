
#!/bin/bash
set -e
PROJECT_DIR="/home/$APP_USER/$APP_PROJECT_DIR"
mkdir -p "$PROJECT_DIR"

useradd -m -s /bin/bash "$APP_USER" && echo "$APP_USER:$APP_USER_PASSWD" | chpasswd
apt-get update && apt-get upgrade -y && apt-get autoremove -y
apt-get install default-jre default-jdk maven git wget -y

git clone "$REPO_URI" "$PROJECT_DIR"

mvn clean package -f "$PROJECT_DIR"
RESULT=$?

if [ $RESULT -ne 0 ]; then
    echo "Error by building the project"
    exit 1
elif [ $RESULT -eq 0 ]; then
    APP_JAR=$(find "$PROJECT_DIR/target" -maxdepth 2 -name '*.jar' ! -name '*.original' -print -quit)

    WORKDIR="/home/$APP_USER/$APP_DIR"
    mkdir -p "$WORKDIR"
    cp "$APP_JAR" "$WORKDIR/PetClinic.jar"
    chown -R "$APP_USER:$APP_USER" "$WORKDIR"
    chmod -R 755 "$WORKDIR"
fi

BASHRC="/home/$APP_USER/.bashrc"

cat >> "$BASHRC" << EOF
export DB_HOST="$DBVM_IP"
export DB_PORT=3306
export DB_NAME="$DB_NAME"
export DB_USER="$DB_USER"
export DB_PASS="$DB_PASS"
EOF

sudo -u "$APP_USER" java -jar "$WORKDIR/PetClinic.jar" &
