#!/bin/bash

# Exit on error, real CI
set -e

echo "Initing openGauss..."

source /home/opengauss/.bashrc

source ~/.bashrc && gs_initdb -D /home/opengauss/openGauss/data/ -w "openGauss2022" -E utf8  --nodename=datanode 
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g"   /home/opengauss/openGauss/data/postgresql.conf
sed -i "s/#port = 5432/port = 5433/g" /home/opengauss/openGauss/data/postgresql.conf && \

echo "Starting openGauss..."
gs_ctl start -D /home/opengauss/openGauss/data -Z single_node

echo "Connecting to openGauss..."
while ! gsql -U opengauss -W openGauss2022 -h 127.0.0.1 -p 5433 -d postgres -c 'SELECT 1' > /dev/null; do
    echo "waiting openGauss start..."
    sleep 1
done

openGauss_webclient --bind=0.0.0.0 --listen=8081 --url "opengauss://opengauss:openGauss2022@0.0.0.0:5433/postgres?sslmode=disable"

