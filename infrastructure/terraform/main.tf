terraform {
  required_version = ">= 1.7.0"
  
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Local development configuration
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-data-mesh-dev"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-data-mesh-dev"
  }
}
