# Deploy Bookinfo Application

Let's deploy the Bookinfo application without sidecar injection first:

```bash
# Deploy the Bookinfo application
kubectl apply -f istio/samples/bookinfo/platform/kube/bookinfo.yaml

# Verify all services are deployed
kubectl get services

# Verify all pods are running
kubectl get pods
```

Wait until all pods are in Running state and ready (1/1):
```bash
kubectl wait --for=condition=Ready pods --all --timeout=300s
```{{exec}}

Verify each service has its endpoints ready:
```bash
kubectl get endpoints | grep -v "none"
```{{exec}}

Test the application by accessing the product page:
```bash
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"
```{{exec}}

If you see the title "Simple Bookstore App", the application is working correctly.

Note: The pods will show 1/1 containers because sidecar injection is not enabled yet. 