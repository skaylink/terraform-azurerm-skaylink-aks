locals {
  metrics_enabled = var.metrics_enabled ? [
    {
      name  = "controller.metrics.enabled"
      value = "true"
    },
    {
      name  = "controller.metrics.serviceMonitor.enabled"
      value = "true"
    },
    {
      name  = "controller.metrics.serviceMonitor.additionalLabels.release"
      value = "kube-prometheus-stack"
    }
  ] : []
}
