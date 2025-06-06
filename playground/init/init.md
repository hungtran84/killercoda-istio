# Istio Service Mesh Playground

Welcome to the Istio Service Mesh playground! This environment provides a fully configured Kubernetes cluster with Istio service mesh installed and ready to use.

## Environment Details

### Kubernetes Cluster
- Version: 1.31
- Setup: 2-node Kubernetes cluster (1 control-plane + 1 worker)
- Container Runtime: containerd
- CNI: Calico

### Istio Service Mesh
- Version: 1.24.0
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

## Verification

You can verify your environment is ready by running:
```bash
# Check Kubernetes nodes
kubectl get nodes

# Verify Istio installation
kubectl get pods -n istio-system

# Check Istio version
istioctl version
```

## What's Next?

You can start:
- Deploying sample applications
- Configuring traffic management
- Setting up security policies
- Exploring observability features

The environment is now ready for your service mesh experiments!
