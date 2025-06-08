#!/bin/bash

# Check if gateway exists
GATEWAY_EXISTS=$(kubectl get gateway bookinfo-gateway -o name 2>/dev/null)
if [ -z "$GATEWAY_EXISTS" ]; then
    echo "Gateway not found"
    exit 1
fi

# Get node1's IP (worker node)
INGRESS_HOST=$(kubectl get nodes -l kubernetes.io/hostname=node01 -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

# Test the product page access
TITLE=$(curl -s "http://${GATEWAY_URL}/productpage" | grep -o "<title>.*</title>")

if [[ $TITLE == *"Simple Bookstore App"* ]]; then
    echo "Gateway is configured correctly and application is accessible"
    exit 0
else
    echo "Cannot access application through gateway"
    exit 1
fi 