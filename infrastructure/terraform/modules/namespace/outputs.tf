output "name" {
  value = kubernetes_namespace.namespace.metadata[0].name
}

output "uid" {
  value = kubernetes_namespace.namespace.metadata[0].uid
}
