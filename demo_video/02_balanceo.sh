#!/bin/bash

clear
echo "============================================================"
echo " DEMO 02 - BALANCEO DE CARGA CON HAPROXY"
echo "============================================================"
echo ""

echo "Se ejecutarán 12 consultas hacia el puerto 3390 de HAProxy."
echo "Debe observarse que las respuestas alternan entre dbnodo1, dbnodo2 y dbnodo3."
echo ""

for i in {1..12}; do
  echo "---------------- Consulta $i ----------------"
  mysql -h 127.0.0.1 -P 3390 -u root -p"$TIDB_PASS" -e "
  SELECT NOW() AS fecha, @@hostname AS servidor_tidb;
  "
  sleep 1
done

echo ""
echo "============================================================"
echo "Logs recientes de HAProxy:"
echo "============================================================"
sudo journalctl -u haproxy --since "3 minutes ago" --no-pager | grep "tidb_backend" | tail -20

echo ""
echo "FIN DEMO 02"
