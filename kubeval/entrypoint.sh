#!/bin/bash -e

set -o pipefail
HELM_INITIALIZED=false
CHARTS_DIR=kubernetes/charts

for chart_path in ${CHARTS_DIR}/*; do
    echo "Processing ${chart_path}"
    
    HELM_BIN=helm

    if [[ $(cat "${chart_path}/Chart.yaml" | grep -E "apiVersion: .?v2") ]]; then
	HELM_BIN=helm3
    elif [[ $HELM_INITIALIZED = false ]]; then
	helm init --client-only
	HELM_INITIALIZED=true
    fi

    ${HELM_BIN} template ${chart_path} | kubeval --ignore-missing-schemas -v 1.18.1 --strict --exit-on-error
done

