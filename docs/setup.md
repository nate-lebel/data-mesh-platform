cat > docs/setup.md << 'EOF'
# Development Environment Setup

## Prerequisites

1. **Windows System Requirements**
    - Windows 10/11 Pro, Enterprise, or Education (for WSL2)
    - 16GB RAM minimum (32GB recommended)
    - 100GB free disk space
    - Virtualization enabled in BIOS

2. **Required Software**
    - Docker Desktop with WSL2 backend
    - WSL2 with Ubuntu 22.04
    - IntelliJ IDEA Ultimate or Community Edition
    - Git for Windows

## Initial Setup

### 1. Clone Repository
```bash
git clone https://github.com/[your-username]/data-mesh-platform.git
cd data-mesh-platform
```
### 2. Run Setup Script
```bash
./scripts/setup/dev-environment.sh
```
### 3. Verify Installation
```bash
kubectl get nodes
kubectl get ns
```
### 4. Access Services
Services are available at:
* Portal: http://portal.datamesh.local
* MinIO: http://minio.datamesh.local
* Grafana: http://grafana.datamesh.local

### 5. IntelliJ IDEA Setup

1. Open project in IntelliJ IDEA
2. Install required plugins:
   - Kubernetes
   - Docker
   - Terraform
   - Python (if using Python services)
3. Configure WSL terminal:
   - Settings → Tools → Terminal
   - Set shell path to: ```wsl.exe```

### 6. Data Contract Development

**Creating a New Contract**
```bash
# Use the contract validation script
./scripts/utils/contract-validate.sh data-contracts/templates/example.yaml
```

**Contract Template**
```yaml
apiVersion: datacontract/v1
kind: DataContract
metadata:
name: example-contract
version: 1.0.0
spec:
description: "Example data contract"
owner: "data-team@company.com"
schema:
type: avro
definition: |
{
"type": "record",
"name": "ExampleRecord",
"fields": [
{"name": "id", "type": "string"},
{"name": "timestamp", "type": "long"}
]
}
```

### 7. Troubleshooting
**Common Issues**
1. **Kind cluster won't start**
```bash
# Delete and recreate
kind delete cluster --name data-mesh-dev
./scripts/setup/dev-environment.sh
```
2. **Ingress not working**
   - Verify hosts file entries
   - Check ingress controller: ```kubectl -n ingress-nginx get pods```
3. **WSL2 memory issues**
Create .wslconfig in Windows user directory:
```ini
[wsl2]
memory=8GB
processors=4
```