# OpenTelemetry Demo Helm Chart

The helm chart installs [OpenTelemetry Demo](https://github.com/open-telemetry/opentelemetry-demo)
in kubernetes cluster.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

Since the OpenTelemetry demo does not build images targeting arm64 architecture **the chart is not supported in clusters running on
arm64 architectures**, such as kind/minikube running on Apple Silicon.

## Installing the Chart

Add OpenTelemetry Helm repository:

```console
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
```

To install the chart with the release name my-otel-demo, run the following command:

```console
helm install my-otel-demo open-telemetry/opentelemetry-demo --values my-values.yaml -n [namespace]
```
NOTE: make sure to match the exposed service in "endpoint: otel-demo-chronocollector-tracing:4317"
