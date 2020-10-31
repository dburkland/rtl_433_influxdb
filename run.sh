#!/bin/sh
/usr/local/bin/rtl_433 -C native -R 40 -F "influx://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db=${INFLUXDB_DBNAME}&u=${INFLUXDB_USERNAME}&p=${INFLUXDB_PASSWORD}"

