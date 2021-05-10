#!/bin/bash -e

set -o pipefail
HELM_INITIALIZED=false
CHARTS_DIR=kubernetes/charts

for chart_path in ${CHARTS_DIR}/*; do
    echo "Processing ${chart_path}"
    helm template ${chart_path} | kubeval --ignore-missing-schemas -v 1.18.1 --strict --exit-on-error
done

