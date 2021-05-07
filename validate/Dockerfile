FROM eu.gcr.io/tradeshift-public/k8s-helm:v3.5.3

RUN apk add bash curl

COPY --from=eu.gcr.io/tradeshift-public/helm-check:latest /quartermaster /
COPY --from=eu.gcr.io/tradeshift-public/helm-check:latest helm-check.sh /

RUN curl -L "https://github.com/instrumenta/kubeval/releases/download/v0.16.1/kubeval-linux-amd64.tar.gz" -o /tmp/kubeval-linux-amd64.tar.gz
RUN tar xvf /tmp/kubeval-linux-amd64.tar.gz -C /tmp
RUN chmod +x /tmp/kubeval
RUN mv /tmp/kubeval /usr/local/bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
