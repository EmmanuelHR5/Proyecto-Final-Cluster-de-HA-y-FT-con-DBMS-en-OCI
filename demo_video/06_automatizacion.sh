#!/bin/bash

clear
echo "============================================================"
echo " DEMO 06 - AUTOMATIZACIÓN, SCRIPTS Y CRON"
echo "============================================================"
echo ""

echo "1) Scripts creados:"
echo ""
ls -lh ~/scripts

echo ""
echo "============================================================"
echo "2) Contenido de backup_tidb.sh:"
echo "============================================================"
cat ~/scripts/backup_tidb.sh

echo ""
echo "============================================================"
echo "3) Contenido de backup_incremental_logico.sh:"
echo "============================================================"
cat ~/scripts/backup_incremental_logico.sh

echo ""
echo "============================================================"
echo "4) Contenido de check_cluster.sh:"
echo "============================================================"
cat ~/scripts/check_cluster.sh

echo ""
echo "============================================================"
echo "5) Contenido de limpiar_logs.sh:"
echo "============================================================"
cat ~/scripts/limpiar_logs.sh

echo ""
echo "============================================================"
echo "6) Contenido de alerta_cluster_correo.sh:"
echo "============================================================"
cat ~/scripts/alerta_cluster_correo.sh

echo ""
echo "============================================================"
echo "7) Cron configurado:"
echo "============================================================"
crontab -l

echo ""
echo "FIN DEMO 06"
