This action runs Kyverno CLI against Helm charts to make sure they respect the policies. One of the validation
rules in the `team` annotation. We need to know the names of the teams beforehand so that we can checkthe charts'
annotations. We do that by listing the `Teams` resources in the cluster and fetching their `helmChartName` attribute.

We also fetch all the policies (`kind: ClusterPolicy`) using `kubectl`, store them in a yaml file and use it in Kyvern
CLI:
```cgo
$ kyverno apply cluster_policies.yaml --resource - -f teams.yaml
```

`--resource -` means that resources are passed to stdin (via `helm template` command). `-f` is the flag for a yaml file
that contains the external data (like team names). And `cluster_policies.yaml` is all the policies we fetched from within
the cluster via `kubectl`.

More information: https://kyverno.io/docs/kyverno-cli/#apply

# Caveats:

In order to apply policies against charts, we need to render the charts. In order to render the charts, we need to find
their override file (in `kubernetes/deployments` dir). That's because there has been no proper validation so far, therefore
some values exist in `kubernetes/deployments` but not in `values.yaml` file. So rendering the chart without its override
file can lead to errors.

Finding the override file in `kubernetes/deployments` dir is not as easy as it should be, because:

1. There can be multiple charts in a Github repo, and therefore multiple files in `kubernetes/deployments`
2. Override files can have numbers at the beginning (e.g. `01_my-chart.config.yaml`). This is used to order chart deployment.

That's why the action has an `if` statement that checks the following:

1. If an override file exists with the same name as the chart, let's use that
2. If an override file exists with the same name as the chart and any number followed by an underscore (`*_my-chart`), let's use that
3. Anything else is not an override file.
