Istio has been installed as described [here](https://istio.io/latest/docs/setup/getting-started).

Check the Istio system pods and services:
```bash
kubectl get po,svc -n istio-system
```{{exec}}

Verify that all Istio components are installed and running:
```bash
istioctl verify-install
```{{exec}}

<br> 