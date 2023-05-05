terraform {
  required_version = "~> 1.4.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.54.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "aks_cluster" {

  source = "../../../../modules/clusters/aks"

  location = var.location

  resource_group_name = var.resource_group_name

  aks_cluster_name = var.aks_cluster_name

  aks_control_plane_k8_version = var.aks_control_plane_k8_version

  aks_worker_plane_k8_version = var.aks_worker_plane_k8_version

  aks_node_pool_name = var.aks_node_pool_name

  aks_node_pool_tier = var.aks_node_pool_tier

  aks_use_azure_network_plugin = var.aks_use_azure_network_plugin

  aks_network_vnet_resource_group = var.aks_network_vnet_resource_group

  aks_network_vnet_name = var.aks_network_vnet_name

  aks_network_subnet_name = var.aks_network_vnet_subnet_name

}
