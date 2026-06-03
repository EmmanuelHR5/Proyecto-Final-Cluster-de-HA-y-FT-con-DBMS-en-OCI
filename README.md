# Proyecto Final: Cluster de Alta Disponibilidad y Tolerancia a Fallos con TiDB en OCI

## Integrantes

- Emmanuel Hernandez - 22130804
- Julio Cesar de la Torre - 22130819

## Descripción del proyecto

Este repositorio contiene la documentación, scripts, configuraciones y evidencias del proyecto final de implementación de un cluster de base de datos con alta disponibilidad y tolerancia a fallos utilizando **TiDB v7.5.0** sobre **Oracle Cloud Infrastructure (OCI)**.

El proyecto implementa un cluster distribuido con tres nodos, balanceo de carga mediante HAProxy, monitoreo con Prometheus/Grafana/Alertmanager, auditoría de operaciones, respaldos, recuperación point-in-time y automatización mediante scripts.

## Arquitectura general

La arquitectura desplegada se compone de:

- 3 nodos TiDB
- 3 nodos PD
- 3 nodos TiKV
- HAProxy como balanceador TCP
- Prometheus para recolección de métricas
- Grafana para visualización y dashboards
- Alertmanager para gestión de alertas
- Backup full y log backup para PITR
- Auditoría local y envío de logs a OCI Object Storage

## Nodos del cluster

| Nodo | IP privada | Roles principales |
|---|---|---|
| dbnodo1 | 10.0.0.174 | TiDB, PD, TiKV, HAProxy, Prometheus, Grafana, Alertmanager |
| dbnodo2 | 10.0.0.73 | TiDB, PD líder/UI, TiKV |
| dbnodo3 | 10.0.0.158 | TiDB, PD, TiKV |

## Puertos principales

| Servicio | Puerto |
|---|---:|
| TiDB SQL | 4000 |
| TiDB Status | 10080 |
| PD | 2379 / 2380 |
| TiKV | 20160 / 20180 |
| HAProxy SQL | 3390 |
| HAProxy Stats | 8080 |
| Grafana | 3000 |
| Prometheus | 9090 |
| Alertmanager | 9093 |

## Conexión al cluster

Conexión mediante HAProxy desde `dbnodo1`:

```bash
mysql -h 127.0.0.1 -P 3390 -u root -p"$TIDB_PASS"
