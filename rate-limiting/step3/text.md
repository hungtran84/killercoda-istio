# Configure API Gateway

Now that the Bookinfo services are running, let's make the application accessible from outside the cluster using an Istio Gateway.

```bash
# Create the Istio Gateway and VirtualService
kubectl apply -f /root/istio-1.24.6/samples/bookinfo/networking/bookinfo-gateway.yaml

# Verify the gateway was created
kubectl get gateway
NAME               AGE
bookinfo-gateway   <age>

# Get the ingress host and port
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')

# Set the gateway URL
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

# Test the external access
curl -s "http://${GATEWAY_URL}/productpage" | grep -o "<title>.*</title>"
```

You should see the title "Simple Bookstore App" in the output. You can also access the application in your browser at:
```
http://${GATEWAY_URL}/productpage
```

Note: If you refresh the page several times, you should see different versions of reviews shown in the product page, presented in a round robin style (red stars, black stars, no stars). 