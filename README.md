# Killercoda Istio ICA

This is the repository for the scenarios available on [killercoda.com/hungts-istio](https://killercoda.com/hungts-istio)

## Environment Details

This playground provides a pre-configured environment with:

- **Kubernetes**:
  - Version: 1.31
  - Setup: 2-node Kubernetes cluster using kubeadm
  - Node Configuration: 1 control plane + 1 worker node

- **Istio**:
  - Version: 1.24.0
  - Installation Method: istioctl
  - Profile: demo
    - Features enabled:
      - Istio Core
      - Istiod
      - Ingress Gateway
      - Egress Gateway
      - Prometheus
      - Grafana
      - Kiali
      - Jaeger

## Getting Started

The playground automatically:
1. Sets up a Kubernetes cluster
2. Installs Istio with the demo profile
3. Configures necessary environment variables and tools

You can verify the installation by running:
```bash
kubectl get pods -n istio-system
istioctl version
```

## Contribute

Would you like to help others by changing, modifying or creating scenarios?

Follow these steps and let us know on [support](https://killercoda.com/support) if you have any questions:

1) Fork this repository
2) Add your fork to your Killercoda account on [killercoda.com/creator/repository](https://killercoda.com/creator/repository) ([help](https://killercoda.com/creators/get-started))
3) Create or modify scenarios and test your changes ([docs](https://killercoda.com/creators)) ([examples](https://github.com/killercoda/scenario-examples))
4) Create a PR from your fork into this repository

## Contact

[killercoda.com/support](https://killercoda.com/support)
