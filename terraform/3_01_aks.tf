####################################
# AKS 
####################################

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-dev"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-dns"

  default_node_pool {
    name                         = "systempool"
    vm_size                      = var.vm_size
    node_count                   = var.node_count
    type                         = "VirtualMachineScaleSets"
    only_critical_addons_enabled = true
    vnet_subnet_id               = azurerm_subnet.snet-aks.id
    max_pods                     = 30
    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  #identity { type = "SystemAssigned" }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uami_aks.id]
  }

  network_profile {
    network_plugin    = "azure" # Azure CNI
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
    service_cidr      = "10.100.110.0/24" #Es un rango virtual usado por Kubernetes para asignar IPs a los ClusterIP Services (servicios internos).
    dns_service_ip    = "10.100.110.10"
    #docker_bridge_cidr = "172.17.0.0/16"
  }

  role_based_access_control_enabled = true
  local_account_disabled            = false

  tags       = { project = var.prefix }
  depends_on = [azurerm_virtual_network.vnet, azurerm_subnet.snet-aks, azurerm_subnet.snet-ingress]
}
##apps nodepool
resource "azurerm_kubernetes_cluster_node_pool" "workloads" {
  name                  = "poolapps"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.vm_size
  node_count            = var.node_count
  vnet_subnet_id        = azurerm_subnet.snet-aks.id
  zones                 = []
  tags = {
    Environment = "dev"
  }
  upgrade_settings {
    drain_timeout_in_minutes      = 0
    max_surge                     = "10%"
    node_soak_duration_in_minutes = 0
  }
  depends_on = [azurerm_kubernetes_cluster.aks]
}