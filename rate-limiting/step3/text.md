# Configure API Gateway

Now that the Bookinfo services are running, let's make the application accessible from outside the cluster using an Istio Gateway.

First, create the Istio Gateway and VirtualService:
```bash
kubectl apply -f istio/samples/bookinfo/networking/bookinfo-gateway.yaml
```{{exec}}

Verify the gateway was created:
```bash
kubectl get gateway
```{{exec}}

Set up the ingress host and port:
```bash
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
```{{exec}}

Test the external access:
```bash
curl -s "http://${GATEWAY_URL}/productpage" | grep -o "<title>.*</title>"
```{{exec}}

You should see the title "Simple Bookstore App" in the output. You can also access the application in your browser at:
```bash
echo "http://${GATEWAY_URL}/productpage"
```{{exec}}

Note: If you refresh the page several times, you should see different versions of reviews shown in the product page, presented in a round robin style (red stars, black stars, no stars). 