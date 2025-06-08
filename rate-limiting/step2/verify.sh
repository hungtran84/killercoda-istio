#!/bin/bash

# Check if all pods are running
PODS_READY=$(kubectl get pods | grep -v NAME | awk '{print $2}' | grep -v '1/1' | wc -l)
if [ $PODS_READY -ne 0 ]; then
    echo "Not all pods are ready"
    exit 1
fi

# Test the product page access
TITLE=$(kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>")

if [[ $TITLE == *"Simple Bookstore App"* ]]; then
    echo "Bookinfo application is working correctly"
    exit 0
else
    echo "Cannot access product page"
    exit 1
fi 