#!/bin/bash

clear
echo "============================================================"
echo " DEMO 03 - ALTA DISPONIBILIDAD / FAILOVER TiDB + HAProxy"
echo "============================================================"
echo ""

echo "1) Estado inicial del clúster:"
tiup cluster display tidb-cluster

echo ""
echo "============================================================"
echo "2) Se detendrá un nodo TiDB: 10.0.0.158:4000"
echo "============================================================"
read -p "Presiona ENTER para detener el nodo..."

START_TIME=$(date +%s)
tiup cluster stop tidb-cluster -N 10.0.0.158:4000 -y

echo ""
echo "============================================================"
echo "3) Estado después de detener el nodo:"
echo "============================================================"
tiup cluster display tidb-cluster

echo ""
echo "Esperando 5 segundos para que HAProxy detecte el nodo caído..."
sleep 5

echo ""
echo "============================================================"
echo "4) Prueba de continuidad por HAProxy"
echo "============================================================"
echo "Si alguna consulta falla al inicio, representa el tiempo de detección/failover."
echo ""

FALLAS=0
EXITOS=0

for i in {1..15}; do
  echo "---------------- Consulta $i ----------------"

  mysql -h 127.0.0.1 -P 3390 -u root -p"$TIDB_PASS" -e "
  SELECT NOW() AS fecha, @@hostname AS servidor_tidb;
  USE proyecto_final;
  SELECT COUNT(*) AS total_tablas
  FROM information_schema.tables
  WHERE table_schema='proyecto_final';
  "

  if [ $? -eq 0 ]; then
    EXITOS=$((EXITOS+1))
  else
    FALLAS=$((FALLAS+1))
    echo "Consulta $i falló temporalmente durante el failover."
  fi

  sleep 1
done

END_TIME=$(date +%s)
DURACION=$((END_TIME-START_TIME))

echo ""
echo "============================================================"
echo "5) Resumen de prueba HA"
echo "============================================================"
echo "Consultas exitosas: $EXITOS"
echo "Consultas fallidas temporalmente: $FALLAS"
echo "Duración aproximada de la prueba: $DURACION segundos"

echo ""
echo "============================================================"
echo "6) HAProxy detectando nodo DOWN:"
echo "============================================================"
sudo journalctl -u haproxy --since "10 minutes ago" --no-pager | grep -i "DOWN\|UP\|tidb_backend" | tail -50

echo ""
echo "============================================================"
echo "7) Se restaurará el nodo detenido: 10.0.0.158:4000"
echo "============================================================"
read -p "Presiona ENTER para volver a iniciar el nodo..."

tiup cluster start tidb-cluster -N 10.0.0.158:4000 -y

echo ""
echo "============================================================"
echo "8) Estado final del clúster:"
echo "============================================================"
tiup cluster display tidb-cluster

echo ""
echo "FIN DEMO 03"
