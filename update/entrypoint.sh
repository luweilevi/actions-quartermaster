#!/bin/bash -ex
update_charts_dependencies() {
  local PROJECT_DIR=$1

  CHARTS_DIR=kubernetes/charts

  helm init --client-only
  for chart_path in ${CHARTS_DIR}/*; do
    if [[ "${chart_path}/requirements.yaml" && ! -d "${chart_path}/charts" ]]; then
      helm dependencies update ${chart_path}
    else
      echo "No external dependencies found for ${chart_path}."
    fi
  done
}

update_charts_dependencies "${PROJECT_DIR}"
