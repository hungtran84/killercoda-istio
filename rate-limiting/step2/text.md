# Deploy Bookinfo Application

Let's deploy the Bookinfo application without sidecar injection first:

Deploy the Bookinfo application:
```bash
kubectl apply -f istio/samples/bookinfo/platform/kube/bookinfo.yaml
```{{exec}}

Verify all services are deployed:
```bash
kubectl get services
```{{exec}}

Verify all pods are running:
```bash
kubectl get pods
```{{exec}}

Test the application by accessing the product page:
```bash
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"
```{{exec}}

Note: The pods will show 1/1 containers because sidecar injection is not enabled yet. 