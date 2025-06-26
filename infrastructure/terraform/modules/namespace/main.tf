resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.name
    
    labels = merge(
      var.labels,
      {
        "mesh.io/component" = var.component
        "mesh.io/managed-by" = "terraform"
      }
    )
    
    annotations = var.annotations
  }
}

resource "kubernetes_network_policy" "default_deny" {
  count = var.enable_network_policy ? 1 : 0
  
  metadata {
    name      = "default-deny-ingress"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  
  spec {
    pod_selector {}
    
    ingress {
      from {
        namespace_selector {
          match_labels = {
            name = kubernetes_namespace.namespace.metadata[0].name
          }
        }
      }
    }
    
    policy_types = ["Ingress"]
  }
}

resource "kubernetes_resource_quota" "quota" {
  count = var.enable_resource_quota ? 1 : 0
  
  metadata {
    name      = "namespace-quota"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  
  spec {
    hard = var.resource_quota
  }
}
