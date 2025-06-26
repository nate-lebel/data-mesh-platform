variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "data-mesh"
}

variable "aws_region" {
  description = "AWS region for production deployment"
  type        = string
  default     = "us-east-1"
}

variable "domain" {
  description = "Base domain for the platform"
  type        = string
  default     = "datamesh.local"
}

variable "namespaces" {
  description = "Kubernetes namespaces to create"
  type        = map(string)
  default = {
    system      = "data-mesh-system"
    catalog     = "data-mesh-catalog"
    processing  = "data-mesh-processing"
    storage     = "data-mesh-storage"
    monitoring  = "data-mesh-monitoring"
  }
}
