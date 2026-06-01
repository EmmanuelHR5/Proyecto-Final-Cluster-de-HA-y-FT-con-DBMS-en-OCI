#!/bin/bash

DESTINO="emmanuelhn108@gmail.com"
TMP="/tmp/estado_tidb.txt"
LOG="/home/rocky/backups/alertas_correo.log"

tiup cluster display tidb-cluster > "$TMP"

if grep -E "Down|Unreachable|Stopped|Error" "$TMP"; then
    echo "===== ALERTA $(date) =====" >> "$LOG"
    grep -E "Down|Unreachable|Stopped|Error" "$TMP" >> "$LOG"
    echo "" >> "$LOG"

    cat "$TMP" | mail -s "ALERTA TiDB: servicio caído en el cluster" "$DESTINO"

    echo "ALERTA generada. Revisa $LOG"
else
    echo "$(date) - Cluster OK" | tee -a "$LOG"
fi
