cat > scripts/deploy/local-services.sh << 'EOF'
#!/bin/bash
set -euo pipefail

echo "Deploying local development services..."

# Deploy PostgreSQL for metadata
helm upgrade --install postgresql bitnami/postgresql \
  --namespace data-mesh-system \
  --set auth.database=datamesh \
  --set auth.username=datamesh \
  --set auth.password=datamesh123 \
  --wait

# Deploy MinIO for object storage
helm upgrade --install minio bitnami/minio \
  --namespace data-mesh-storage \
  --set auth.rootUser=admin \
  --set auth.rootPassword=admin123 \
  --set defaultBuckets="data-products,contracts,raw-data" \
  --set ingress.enabled=true \
  --set ingress.hostname=minio.datamesh.local \
  --set ingress.ingressClassName=nginx \
  --wait

# Create test ingress
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: test-ingress
  namespace: default
spec:
  ingressClassName: nginx
  rules:
    - host: datamesh.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: test-service
                port:
                  number: 80
EOF

echo "Local services deployed successfully!"