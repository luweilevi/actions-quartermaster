FROM eu.gcr.io/tradeshift-public/k8s-helm:v3.5.3

RUN apk add bash

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
