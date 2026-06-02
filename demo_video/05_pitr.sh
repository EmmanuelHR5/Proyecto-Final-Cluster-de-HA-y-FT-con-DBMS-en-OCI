#!/bin/bash

clear
echo "============================================================"
echo " DEMO 05 - RECUPERACIÓN POINT-IN-TIME PITR"
echo "============================================================"
echo ""

echo "1) Mostrar respaldos existentes:"
echo ""
ls -lh ~/backups/pitr_demo 2>/dev/null

echo ""
echo "Tamaño de fullbackup:"
du -sh ~/backups/pitr_demo/fullbackup 2>/dev/null

echo ""
echo "Tamaño de logbackup:"
du -sh ~/backups/pitr_demo/logbackup 2>/dev/null

echo ""
echo "============================================================"
echo "2) Mostrar evidencia de restauración exitosa:"
echo "============================================================"
grep -i "success summary\|restore-to\|restore-from" ~/evidencias_finales/13_pitr_exitoso.txt

echo ""
echo "============================================================"
echo "3) Validación de base restaurada:"
echo "============================================================"
cat ~/evidencias_pitr/01_restore_pitr_validacion_bd.txt 2>/dev/null

echo ""
echo "============================================================"
echo "4) Conteo de tablas restauradas:"
echo "============================================================"
cat ~/evidencias_pitr/03_restore_pitr_conteo_tablas.txt 2>/dev/null

echo ""
echo "============================================================"
echo "5) Guardar evidencia PITR para video:"
echo "============================================================"

cat > ~/evidencias_finales/26_prueba_pitr_video.txt <<EOT
=== PRUEBA PITR PARA VIDEO ===

Objetivo:
Demostrar que el clúster TiDB cuenta con respaldo completo, respaldo de logs y evidencia de recuperación point-in-time.

=== Backups existentes ===
EOT

du -sh ~/backups/pitr_demo/fullbackup >> ~/evidencias_finales/26_prueba_pitr_video.txt 2>&1
du -sh ~/backups/pitr_demo/logbackup >> ~/evidencias_finales/26_prueba_pitr_video.txt 2>&1

cat >> ~/evidencias_finales/26_prueba_pitr_video.txt <<EOT

=== Evidencia de restauración exitosa ===
EOT

cat ~/evidencias_finales/13_pitr_exitoso.txt >> ~/evidencias_finales/26_prueba_pitr_video.txt 2>&1

cat >> ~/evidencias_finales/26_prueba_pitr_video.txt <<EOT

=== Validación de datos restaurados ===
EOT

cat ~/evidencias_pitr/01_restore_pitr_validacion_bd.txt >> ~/evidencias_finales/26_prueba_pitr_video.txt 2>&1
cat ~/evidencias_pitr/03_restore_pitr_conteo_tablas.txt >> ~/evidencias_finales/26_prueba_pitr_video.txt 2>&1

cat ~/evidencias_finales/26_prueba_pitr_video.txt

echo ""
echo "FIN DEMO 05"
