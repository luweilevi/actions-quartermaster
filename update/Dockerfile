FROM lachlanevenson/k8s-helm:v2.16.1

RUN apk add bash
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
