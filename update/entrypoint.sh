#!/bin/bash -ex
update_charts_dependencies() {
  local HELM_INITIALIZED=false
  local CHARTS_DIR=kubernetes/charts

  for chart_path in ${CHARTS_DIR}/*; do
    HELM_BIN=helm3

    if [[ ( -f "${chart_path}/requirements.yaml" && ! -d "${chart_path}/charts") || $(cat "${chart_path}/Chart.yaml" | grep -E "dependencies:")  ]]; then
      ${HELM_BIN} dependencies update ${chart_path}
    else
      echo "No external dependencies found for ${chart_path}."
    fi
  done
}

update_charts_dependencies
