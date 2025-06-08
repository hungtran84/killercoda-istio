# Deploy Bookinfo Application

Let's deploy the Bookinfo application without sidecar injection first:

```bash
# Deploy the Bookinfo application
kubectl apply -f /root/istio-1.24.6/samples/bookinfo/platform/kube/bookinfo.yaml

# Verify all services are deployed
kubectl get services

# Verify all pods are running
kubectl get pods

# Test the application
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"
```

Note: The pods will show 1/1 containers because sidecar injection is not enabled yet.