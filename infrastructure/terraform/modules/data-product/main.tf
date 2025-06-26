locals {
  labels = merge(
    var.labels,
    {
      "mesh.io/data-product" = var.name
      "mesh.io/domain"       = var.domain
      "mesh.io/team"         = var.team
    }
  )
}

resource "kubernetes_namespace" "data_product" {
  metadata {
    name = "dp-${var.name}"
    labels = local.labels
  }
}

resource "kubernetes_service_account" "data_product" {
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.data_product.metadata[0].name
    labels    = local.labels
  }
}

resource "kubernetes_role" "data_product" {
  metadata {
    name      = "${var.name}-role"
    namespace = kubernetes_namespace.data_product.metadata[0].name
    labels    = local.labels
  }
  
  rule {
    api_groups = [""]
    resources  = ["pods", "services", "configmaps", "secrets"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
  
  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "statefulsets"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
  
  rule {
    api_groups = ["batch"]
    resources  = ["jobs", "cronjobs"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

resource "kubernetes_role_binding" "data_product" {
  metadata {
    name      = "${var.name}-rolebinding"
    namespace = kubernetes_namespace.data_product.metadata[0].name
    labels    = local.labels
  }
  
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.data_product.metadata[0].name
  }
  
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.data_product.metadata[0].name
    namespace = kubernetes_namespace.data_product.metadata[0].name
  }
}

resource "kubernetes_config_map" "data_contract" {
  metadata {
    name      = "${var.name}-contract"
    namespace = kubernetes_namespace.data_product.metadata[0].name
    labels    = local.labels
  }
  
  data = {
    "contract.yaml" = var.data_contract
  }
}
