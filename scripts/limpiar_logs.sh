#!/bin/bash

echo "Limpiando logs antiguos mayores a 7 días..."

find /home/rocky/tidb-deploy -type f -name "*.log" -mtime +7 -print

find /home/rocky/tidb-deploy -type f -name "*.log" -mtime +7 -delete

echo "Limpieza terminada."
