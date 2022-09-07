# actions-helm

Opinionated GitHub Actions for checking helm charts

Example:

```
jobs:
  run:
    runs-on: self-hosted
    steps:
      - name: Checkout repo
        uses: actions/checkout@v2
        with:
          ref: ${{ github.event.pull_request.head.sha }}
      - name: Helm update
        uses: tradeshift/actions-quartermaster/update@master
      - name: Helm lint
        uses: tradeshift/actions-quartermaster/lint@master
      - name: Helm kubeval
        uses: tradeshift/actions-quartermaster/kubeval@master
```