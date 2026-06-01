#!/bin/bash

BACKUP_DIR="/home/rocky/backups"
FECHA=$(date +%F_%H-%M)
DB="proyecto_final"
USER="root"
PASS='^f87-dE1Q96Y@F4i+q'
HOST="127.0.0.1"
PORT="3390"

mkdir -p "$BACKUP_DIR"

mysqldump -h "$HOST" -P "$PORT" -u "$USER" -p"$PASS" "$DB" > "$BACKUP_DIR/${DB}_${FECHA}.sql"

echo "Backup generado: $BACKUP_DIR/${DB}_${FECHA}.sql"
