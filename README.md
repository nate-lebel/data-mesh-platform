# Data Mesh Platform

Enterprise-grade data mesh platform built on Kubernetes with support for data contracts, distributed governance, and self-service data infrastructure.

## Architecture
- **Development**: Windows Docker Desktop with WSL2
- **Production**: AWS EKS with ECR
- **Data Contracts**: Powered by datacontract-cli
- **Orchestration**: Kubernetes with GitOps

## Quick Start
See [docs/setup.md](docs/setup.md) for detailed setup instructions.

## Project Structure
```
data-mesh-platform/
├── infrastructure/  # IaC and Kubernetes configs
├── services/        # Platform microservices
├── data-contracts/  # Contract definitions and templates
├── web-portal/      # Central management UI
├── scripts/         # Automation tooling
└── docs/            # Documentation
```