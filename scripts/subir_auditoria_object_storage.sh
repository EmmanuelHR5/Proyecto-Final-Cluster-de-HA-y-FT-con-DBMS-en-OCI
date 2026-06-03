#!/bin/bash

# subir_auditoria_object_storage.sh
# Sube logs de auditoría local a OCI Object Storage

FECHA=$(date +"%Y%m%d_%H%M%S")
LOG_LOCAL="/var/log/dbmaintenance/audit_tidb_demo.log"

BUCKET="tidb-auditoria-logs"
NAMESPACE="idvtbl8tedo6"
OBJETO="auditoria/audit_tidb_demo_${FECHA}.log"

echo "Subiendo log de auditoría a OCI Object Storage..."

if ! command -v oci >/dev/null 2>&1; then
    echo "ERROR: OCI CLI no está instalado o no está en el PATH."
    exit 1
fi

if [ ! -f "$LOG_LOCAL" ]; then
    echo "ERROR: No existe el archivo de auditoría:"
    echo "$LOG_LOCAL"
    exit 1
fi

oci os object put \
  --namespace-name "$NAMESPACE" \
  --bucket-name "$BUCKET" \
  --file "$LOG_LOCAL" \
  --name "$OBJETO" \
  --force

if [ $? -eq 0 ]; then
    echo "Log subido correctamente a OCI Object Storage:"
    echo "$OBJETO"
else
    echo "Error al subir el log"
    exit 1
fi
