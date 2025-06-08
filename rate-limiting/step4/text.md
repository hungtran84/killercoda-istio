# Configure Global Rate Limiting

In this step, we'll implement global rate limiting for the Bookinfo application using Envoy's global rate limiting service.

## Deploy the Rate Limit Service

First, let's deploy the rate limit service and its configuration:

```bash
# Create rate limit configuration
kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: ratelimit-config
data:
  config.yaml: |
    domain: productpage-ratelimit
    descriptors:
      - key: PATH
        value: "/"
        rate_limit:
          unit: minute
          requests_per_unit: 1
      - key: PATH
        value: "api"
        rate_limit:
          unit: minute
          requests_per_unit: 2
EOF
```{{exec}}

Now deploy the rate limit service:

```bash
kubectl apply -f istio/samples/ratelimit/rate-limit-service.yaml
```{{exec}}

## Configure the EnvoyFilter

Apply an EnvoyFilter to enable rate limiting at the gateway:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: EnvoyFilter
metadata:
  name: filter-ratelimit
  namespace: istio-system
spec:
  workloadSelector:
    labels:
      istio: ingressgateway
  configPatches:
    - applyTo: HTTP_FILTER
      match:
        context: GATEWAY
        listener:
          filterChain:
            filter:
              name: "envoy.filters.network.http_connection_manager"
      patch:
        operation: INSERT_BEFORE
        value:
          name: envoy.filters.http.ratelimit
          typed_config:
            "@type": type.googleapis.com/udpa.type.v1.TypedStruct
            type_url: type.googleapis.com/envoy.extensions.filters.http.ratelimit.v3.RateLimit
            value:
              domain: productpage-ratelimit
              failure_mode_deny: false
              rate_limit_service:
                grpc_service:
                  envoy_grpc:
                    cluster_name: rate_limit_cluster
                  timeout: 10s
                transport_api_version: V3
EOF
```{{exec}}

## Test the Rate Limiting

Let's test the rate limiting configuration:

1. Test the product page rate limit (1 request per minute):
```bash
for i in {1..2}; do curl -s "http://${GATEWAY_URL}/productpage" -o /dev/null -w "%{http_code}\n"; sleep 3; done
```{{exec}}

You should see:
- First request: HTTP 200 (OK)
- Second request: HTTP 429 (Too Many Requests)

2. Test the API rate limit (2 requests per minute):
```bash
for i in {1..3}; do curl -s "http://${GATEWAY_URL}/api/v1/products/${i}" -o /dev/null -w "%{http_code}\n"; sleep 3; done
```{{exec}}

You should see:
- First two requests: HTTP 200 (OK)
- Third request: HTTP 429 (Too Many Requests)

## Understanding the Configuration

The rate limiting configuration:
- Limits access to `/productpage` to 1 request per minute
- Limits access to `/api/v1/products/*` to 2 requests per minute
- Returns HTTP 429 when rate limit is exceeded
- Uses a global rate limit service for consistent limiting across all instances 