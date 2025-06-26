#!/bin/bash
set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Setting up Data Mesh Development Environment${NC}"

# Check prerequisites
check_command() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}Error: $1 is not installed${NC}"
        exit 1
    fi
}

echo "Checking prerequisites..."
check_command docker
check_command kubectl
check_command helm
check_command kind
check_command terraform

# Create Kind cluster if not exists
if ! kind get clusters | grep -q data-mesh-dev; then
    echo -e "${YELLOW}Creating Kind cluster...${NC}"
    kind create cluster --config infrastructure/k8s-manifests/kind-config.yaml
else
    echo -e "${GREEN}Kind cluster already exists${NC}"
fi

# Set kubectl context
kubectl config use-context kind-data-mesh-dev

# Install Ingress Controller
echo -e "${YELLOW}Installing NGINX Ingress Controller...${NC}"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.6/deploy/static/provider/kind/deploy.yaml

# Create namespaces
echo -e "${YELLOW}Creating namespaces...${NC}"
kubectl create namespace data-mesh-system --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace data-mesh-catalog --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace data-mesh-processing --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace data-mesh-storage --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace data-mesh-monitoring --dry-run=client -o yaml | kubectl apply -f -

# Add Helm repositories
echo -e "${YELLOW}Adding Helm repositories...${NC}"
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

echo -e "${GREEN}Development environment setup complete!${NC}"
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Run 'kubectl get nodes' to verify cluster"
echo "2. Run 'scripts/deploy/local-services.sh' to deploy base services"
