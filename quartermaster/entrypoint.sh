#!/bin/bash -ex
export CHARTS_DIR=kubernetes/charts

for chart_path in ${CHARTS_DIR}/*; do
  if [[ ( -f "${chart_path}/requirements.yaml" && ! -d "${chart_path}/charts") || $(cat "${chart_path}/Chart.yaml" | grep -E "dependencies:")  ]]; then
    helm dependencies update ${chart_path}
  else
    echo "No external dependencies found for ${chart_path}."
  fi
  helm template ${chart_path} | kubeval --ignore-missing-schemas -v 1.18.1 --strict --exit-on-error

done
/helm-check.sh kubernetes
