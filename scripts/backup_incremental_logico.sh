#!/bin/bash

BACKUP_DIR="/home/rocky/backups/incremental"
FECHA=$(date +%F_%H-%M)
DB="proyecto_final"
USER="root"
PASS='^f87-dE1Q96Y@F4i+q'
HOST="127.0.0.1"
PORT="3390"

mkdir -p "$BACKUP_DIR"

mysqldump -h "$HOST" -P "$PORT" -u "$USER" -p"$PASS" \
  --skip-lock-tables \
  --skip-add-locks \
  --routines \
  --events \
  "$DB" > "$BACKUP_DIR/${DB}_incremental_logico_${FECHA}.sql"

if [ $? -eq 0 ]; then
    echo "Backup incremental lógico generado correctamente: $BACKUP_DIR/${DB}_incremental_logico_${FECHA}.sql"
else
    echo "ERROR: falló el backup incremental lógico"
    rm -f "$BACKUP_DIR/${DB}_incremental_logico_${FECHA}.sql"
    exit 1
fi
