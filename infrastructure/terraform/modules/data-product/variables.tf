variable "name" {
  description = "Data product name"
  type        = string
}

variable "domain" {
  description = "Business domain"
  type        = string
}

variable "team" {
  description = "Owning team"
  type        = string
}

variable "data_contract" {
  description = "Data contract YAML"
  type        = string
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}

variable "storage_size" {
  description = "Storage size for data product"
  type        = string
  default     = "10Gi"
}

variable "enable_streaming" {
  description = "Enable Kafka topics"
  type        = bool
  default     = false
}

variable "kafka_topics" {
  description = "Kafka topics to create"
  type = list(object({
    name       = string
    partitions = number
    replicas   = number
  }))
  default = []
}
