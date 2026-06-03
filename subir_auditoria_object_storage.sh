#!/bin/bash

# subir_auditoria_object_storage.sh
# Sube logs de auditoría local a OCI Object Storage

FECHA=$(date +"%Y%m%d_%H%M%S")
LOG_LOCAL="/var/log/dbmaintenance/audit_tidb_demo.log"
BUCKET="tidb-auditoria-logs"
NAMESPACE="TU_NAMESPACE_OCI"
OBJETO="auditoria/audit_tidb_demo_${FECHA}.log"

echo "Subiendo log de auditoría a OCI Object Storage..."

oci os object put \
  --namespace-name "$NAMESPACE" \
  --bucket-name "$BUCKET" \
  --file "$LOG_LOCAL" \
  --name "$OBJETO" \
  --force

if [ $? -eq 0 ]; then
    echo "Log subido correctamente: $OBJETO"
else
    echo "Error al subir el log"
fi
