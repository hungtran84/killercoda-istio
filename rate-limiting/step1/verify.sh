#!/bin/bash

# Check if istiod is running
ISTIOD_READY=$(kubectl get pods -n istio-system -l app=istiod -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}')
if [ "$ISTIOD_READY" != "True" ]; then
    echo "Istiod is not ready"
    exit 1
fi

# Check if ingress gateway is running
INGRESS_READY=$(kubectl get pods -n istio-system -l app=istio-ingressgateway -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}')
if [ "$INGRESS_READY" != "True" ]; then
    echo "Ingress Gateway is not ready"
    exit 1
fi

# Check if egress gateway is running
EGRESS_READY=$(kubectl get pods -n istio-system -l app=istio-egressgateway -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}')
if [ "$EGRESS_READY" != "True" ]; then
    echo "Egress Gateway is not ready"
    exit 1
fi

echo "Istio is properly installed and running"
exit 0 