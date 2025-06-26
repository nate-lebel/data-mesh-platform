variable "name" {
  description = "Namespace name"
  type        = string
}

variable "component" {
  description = "Component type"
  type        = string
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}

variable "annotations" {
  description = "Namespace annotations"
  type        = map(string)
  default     = {}
}

variable "enable_network_policy" {
  description = "Enable default network policy"
  type        = bool
  default     = true
}

variable "enable_resource_quota" {
  description = "Enable resource quota"
  type        = bool
  default     = false
}

variable "resource_quota" {
  description = "Resource quota limits"
  type        = map(string)
  default = {
    "requests.cpu"    = "10"
    "requests.memory" = "20Gi"
    "limits.cpu"      = "20"
    "limits.memory"   = "40Gi"
  }
}
