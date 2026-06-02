#!/bin/bash

clear
echo "============================================================"
echo " DEMO 07 - COMPRESIÓN FINAL DE EVIDENCIAS"
echo "============================================================"
echo ""

cd /home/rocky || exit 1

tar --exclude='evidencias_finales/evidencias_finales_tidb.tar.gz' \
    -czvf evidencias_finales_tidb.tar.gz \
    evidencias_finales evidencias_pitr

echo ""
echo "============================================================"
echo "Archivo generado:"
echo "============================================================"
ls -lh /home/rocky/evidencias_finales_tidb.tar.gz

echo ""
echo "============================================================"
echo "Verificación de evidencias clave:"
echo "============================================================"
tar -tzf /home/rocky/evidencias_finales_tidb.tar.gz | grep -E "20_prueba_ha|25_prueba_auditoria_video|26_prueba_pitr_video|13_pitr_exitoso|23_auditoria"

echo ""
echo "FIN DEMO 07"
