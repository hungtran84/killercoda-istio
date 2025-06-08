# Istio Rate Limiting

Welcome to the Istio Rate Limiting scenario! This environment provides a fully configured Kubernetes cluster with Istio service mesh installed and ready to use.

## Environment Details

### Kubernetes Cluster
- Version: 1.32
- Setup: 2-node Kubernetes cluster (1 control-plane + 1 worker)
- Container Runtime: containerd

### Istio Service Mesh
- Version: 1.24.6
- Installation Method: istioctl
- Profile: demo (includes all core features)

### Pre-installed Components
- **Core Components**
  - istiod (control plane)
  - istio-ingressgateway
  - istio-egressgateway

- **Observability Stack**
  - Prometheus
  - Grafana
  - Kiali
  - Jaeger

The environment is now ready for implementing rate limiting with Istio! 