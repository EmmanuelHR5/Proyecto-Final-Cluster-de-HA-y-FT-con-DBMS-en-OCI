#!/bin/bash

clear
echo "============================================================"
echo " DEMO 04 - AUDITORÍA AUTOMÁTICA TiDB"
echo "============================================================"
echo ""

echo "1) Estado del servicio de auditoría:"
echo ""
sudo systemctl status auditoria-tidb-auto --no-pager

echo ""
echo "============================================================"
echo "2) Validar que tidb_general_log está activo:"
echo "============================================================"
mysql -h 127.0.0.1 -P 4000 -u root -p"$TIDB_PASS" -e "
SHOW VARIABLES LIKE 'tidb_general_log';
"

echo ""
echo "============================================================"
echo "3) Limpiar log de auditoría para la demo:"
echo "============================================================"
> /var/log/dbmaintenance/audit_tidb_auto.log
echo "Log limpiado: /var/log/dbmaintenance/audit_tidb_auto.log"

sleep 2

echo ""
echo "============================================================"
echo "4) Ejecutar operaciones SQL reales:"
echo "============================================================"

mysql -h 127.0.0.1 -P 4000 -u root -p"$TIDB_PASS" <<'SQL'
USE proyecto_final;

DROP TABLE IF EXISTS auditoria_video_demo;

CREATE TABLE auditoria_video_demo (
    id BIGINT PRIMARY KEY AUTO_RANDOM,
    accion VARCHAR(100),
    usuario VARCHAR(50),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO auditoria_video_demo (accion, usuario)
VALUES 
('INSERT de prueba para auditoría', 'root'),
('Segundo registro de prueba', 'root');

SELECT * FROM auditoria_video_demo;

UPDATE auditoria_video_demo
SET accion = 'UPDATE detectado por auditoría'
WHERE usuario = 'root'
LIMIT 1;

SELECT * FROM auditoria_video_demo;

DELETE FROM auditoria_video_demo
WHERE accion = 'Segundo registro de prueba'
LIMIT 1;

SELECT * FROM auditoria_video_demo;

DROP TABLE auditoria_video_demo;
SQL

sleep 2

echo ""
echo "============================================================"
echo "5) Mostrar operaciones detectadas automáticamente en el log:"
echo "============================================================"

grep '\[GENERAL_LOG\]\|CRUCIAL OPERATION' /var/log/dbmaintenance/audit_tidb_auto.log \
| grep -Ei 'sql="(CREATE|INSERT|SELECT|UPDATE|DELETE|DROP|use)' \
| awk '!seen[$0]++' \
| tail -30

echo ""
echo "============================================================"
echo "6) Guardar evidencia:"
echo "============================================================"

cat > ~/evidencias_finales/25_prueba_auditoria_video.txt <<EOT
=== PRUEBA DE AUDITORÍA AUTOMÁTICA PARA VIDEO ===

Objetivo:
Demostrar que las operaciones SQL ejecutadas en TiDB se registran automáticamente en un log de auditoría.

=== Servicio de auditoría ===
EOT

sudo systemctl status auditoria-tidb-auto --no-pager >> ~/evidencias_finales/25_prueba_auditoria_video.txt 2>&1

cat >> ~/evidencias_finales/25_prueba_auditoria_video.txt <<EOT

=== General log activo ===
EOT

mysql -h 127.0.0.1 -P 4000 -u root -p"$TIDB_PASS" -e "
SHOW VARIABLES LIKE 'tidb_general_log';
" >> ~/evidencias_finales/25_prueba_auditoria_video.txt 2>&1

cat >> ~/evidencias_finales/25_prueba_auditoria_video.txt <<EOT

=== Operaciones detectadas automáticamente ===
EOT

grep '\[GENERAL_LOG\]\|CRUCIAL OPERATION' /var/log/dbmaintenance/audit_tidb_auto.log \
| grep -Ei 'sql="(CREATE|INSERT|SELECT|UPDATE|DELETE|DROP|use)' \
| awk '!seen[$0]++' \
| tail -40 >> ~/evidencias_finales/25_prueba_auditoria_video.txt

cat ~/evidencias_finales/25_prueba_auditoria_video.txt

echo ""
echo "FIN DEMO 04"
