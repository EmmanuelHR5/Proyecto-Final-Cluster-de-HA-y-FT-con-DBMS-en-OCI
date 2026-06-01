#!/bin/bash

echo "===== Estado del cluster TiDB ====="
tiup cluster display tidb-cluster

echo ""
echo "===== Prueba SQL por HAProxy ====="
mysql -h 127.0.0.1 -P 3390 -u root -p'^f87-dE1Q96Y@F4i+q' -e "USE proyecto_final; SELECT COUNT(*) AS total_pedidos FROM pedidos;"
