#!/bin/bash

HOST="127.0.0.1"
PORT="3390"
USER="root"
PASS="$TIDB_PASS"
DB="proyecto_final"

echo "=== Medición de RTO por HAProxy ==="
echo "Inicio: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Consultas cada 1 segundo. Detén un TiDB en otra terminal."
echo

while true; do
    FECHA=$(date '+%Y-%m-%d %H:%M:%S')
    INICIO=$(date +%s%3N)

    mysql -h "$HOST" -P "$PORT" -u "$USER" -p"$PASS" "$DB" -e "
    SELECT NOW() AS fecha, @@hostname AS servidor_tidb;
    " >/tmp/rto_tidb.out 2>/tmp/rto_tidb.err

    FIN=$(date +%s%3N)
    DURACION=$((FIN - INICIO))

    if [ $? -eq 0 ]; then
        SERVIDOR=$(tail -n 1 /tmp/rto_tidb.out | awk '{print $2}')
        echo "$FECHA | OK | servidor=$SERVIDOR | tiempo=${DURACION}ms"
    else
        echo "$FECHA | ERROR | tiempo=${DURACION}ms"
        cat /tmp/rto_tidb.err
    fi

    sleep 1
done
