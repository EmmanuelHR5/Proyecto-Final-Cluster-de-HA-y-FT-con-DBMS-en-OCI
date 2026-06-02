#!/bin/bash

clear
echo "============================================================"
echo " DEMO 01 - ESTADO GENERAL DEL CLÚSTER TiDB"
echo "============================================================"
echo ""

echo "1) Estado del clúster con TiUP:"
echo ""
tiup cluster display tidb-cluster

echo ""
echo "============================================================"
echo "2) Estado de HAProxy:"
echo "============================================================"
sudo systemctl status haproxy --no-pager

echo ""
echo "============================================================"
echo "3) Conexión a TiDB por HAProxy puerto 3390:"
echo "============================================================"
mysql -h 127.0.0.1 -P 3390 -u root -p"$TIDB_PASS" -e "
SELECT NOW() AS fecha, @@hostname AS servidor;
SHOW DATABASES;
"

echo ""
echo "FIN DEMO 01"
