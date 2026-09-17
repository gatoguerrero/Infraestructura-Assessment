############################################################
# NGINX INGRESS (INTERNO)
############################################################

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  timeout          = 1800
  wait             = true
  cleanup_on_fail  = true

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.10.0"

  values = [
    yamlencode({
      controller = {
        replicaCount = 2
        # Integrado: Permite que NGINX entre en nodos con taints de sistema si fuera necesario
        tolerations = [
          {
            key      = "CriticalAddonsOnly"
            operator = "Exists"
            effect   = "NoSchedule"
          }
        ]

        nodeSelector = {
          "agentpool" = "poolapps"
        }
        service = {
          type = "LoadBalancer"
          annotations = {
            "service.beta.kubernetes.io/azure-load-balancer-internal"                  = "true"
            "service.beta.kubernetes.io/azure-load-balancer-internal-subnet"           = azurerm_subnet.snet-ingress.name
            "service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path" = "/healthz"
          }
        }
      }
    })
  ]

  depends_on = [
    azurerm_kubernetes_cluster_node_pool.workloads,
    azurerm_role_assignment.uami_role_rg
  ]
}
