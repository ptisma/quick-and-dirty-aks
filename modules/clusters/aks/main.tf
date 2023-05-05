terraform {
  required_version = "~> 1.4.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.54.0"
    }
  }
}

data "azurerm_subnet" "subnet" {
  count = var.aks_use_azure_network_plugin ? 1 : 0
  resource_group_name = var.aks_network_vnet_resource_group
  virtual_network_name = var.aks_network_vnet_name
  name = var.aks_network_subnet_name
}

resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  kubernetes_version  = var.aks_control_plane_k8_version
  dns_prefix = "petar-aks-test"

  default_node_pool {
    name       = var.aks_node_pool_name
    vm_size    = var.aks_node_pool_tier
    vnet_subnet_id = local.vnet_subnet_id
    enable_auto_scaling = true
    min_count = var.aks_min_node_count
    max_count = var.aks_max_node_count
    orchestrator_version  = var.aks_worker_plane_k8_version
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = local.network_plugin
  }

  tags = var.aks_tags
}

locals {
  network_plugin = var.aks_use_azure_network_plugin ? "azure" : "kubenet"
  vnet_subnet_id = var.aks_use_azure_network_plugin ? data.azurerm_subnet.subnet[0].id : null
  
}