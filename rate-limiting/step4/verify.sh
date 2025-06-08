#!/bin/bash

# Check if rate limit service is deployed
RATELIMIT_POD=$(kubectl get pod -l app=ratelimit -o name 2>/dev/null)
if [ -z "$RATELIMIT_POD" ]; then
    echo "Rate limit service not found"
    exit 1
fi

# Check if rate limit config exists
RATELIMIT_CONFIG=$(kubectl get configmap ratelimit-config -o name 2>/dev/null)
if [ -z "$RATELIMIT_CONFIG" ]; then
    echo "Rate limit config not found"
    exit 1
fi

# Check if EnvoyFilter exists
ENVOYFILTER=$(kubectl get envoyfilter filter-ratelimit -n istio-system -o name 2>/dev/null)
if [ -z "$ENVOYFILTER" ]; then
    echo "Rate limit EnvoyFilter not found"
    exit 1
fi

# Get gateway URL
INGRESS_HOST=$(kubectl get nodes -l kubernetes.io/hostname=node01 -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

# Test rate limiting
RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" "http://${GATEWAY_URL}/productpage")
sleep 1
RATE_LIMITED_CODE=$(curl -s -o /dev/null -w "%{http_code}" "http://${GATEWAY_URL}/productpage")

if [ "$RESPONSE_CODE" = "200" ] && [ "$RATE_LIMITED_CODE" = "429" ]; then
    echo "Rate limiting is working correctly"
    exit 0
else
    echo "Rate limiting is not working as expected"
    exit 1
fi 