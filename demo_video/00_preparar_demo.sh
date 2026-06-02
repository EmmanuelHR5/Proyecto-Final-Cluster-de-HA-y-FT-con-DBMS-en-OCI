#!/bin/bash

clear
echo "============================================================"
echo " PREPARACIÓN DE DEMO"
echo "============================================================"
echo ""

if [ -z "$TIDB_PASS" ]; then
  echo "ERROR: La variable TIDB_PASS no está definida."
  echo "Ejecuta primero:"
  echo "export TIDB_PASS='TU_CONTRASEÑA'"
  exit 1
fi

echo "Variable TIDB_PASS detectada."
echo ""

echo "Probando conexión por HAProxy..."
mysql -h 127.0.0.1 -P 3390 -u root -p"$TIDB_PASS" -e "
SELECT NOW() AS fecha, @@hostname AS servidor;
" || exit 1

echo ""
echo "Verificando clúster..."
tiup cluster display tidb-cluster | grep -E "tidb|tikv|pd|grafana|prometheus|alertmanager|Total nodes"

echo ""
echo "Verificando HAProxy..."
sudo systemctl is-active haproxy

echo ""
echo "Verificando auditoría automática..."
sudo systemctl is-active auditoria-tidb-auto

echo ""
echo "Verificando tidb_general_log..."
mysql -h 127.0.0.1 -P 4000 -u root -p"$TIDB_PASS" -e "
SHOW VARIABLES LIKE 'tidb_general_log';
"

echo ""
echo "Todo listo para grabar."
