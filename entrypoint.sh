#!/bin/bash

# Exit on error, real CI
set -e

source /var/lib/opengauss/.bash_profile

echo "Starting openGauss..."

gs_ctl start -D /var/lib/opengauss/data -Z single_node

echo "Connecting to openGauss..."
while ! gsql -U opengauss -W opengauss_2022 -h 127.0.0.1 -p 7654 -d postgres -c 'SELECT 1' > /dev/null; do
    echo "waiting openGauss start..."
    sleep 1
done

openGauss_webclient --bind=0.0.0.0 --listen=8081 --url "opengauss://opengauss:opengauss_2022@0.0.0.0:7654/postgres?sslmode=disable"
