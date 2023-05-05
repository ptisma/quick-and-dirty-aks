# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "location" {
  description = "The azure location to use for all the resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name to use for the resource group"
  type        = string
}

variable "aks_cluster_name" {
  description = "The name to use for aks cluster"
  type        = string
}

variable "aks_control_plane_k8_version" {
  description = "The k8 version to use for aks cluster control plane"
  type        = string
}

variable "aks_worker_plane_k8_version" {
  description = "The k8 version to use for aks cluster worker plane"
  type        = string
}

variable "aks_node_pool_name" {
  description = "The name to use for the aks node pool"
  type        = string
}

variable "aks_node_pool_tier" {
  description = "The compute tier to use for the aks node pool"
  type        = string
}

variable "aks_use_azure_network_plugin" {
  description = "Use either azure network plugin or kubenet"
  type        = bool
}



# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable aks_min_node_count {
  type        = number
  description = "Minimum number of Nodes to create for the cluster"
  default = 1
}

variable aks_max_node_count {
  type        = number
  description = "Maximum number of Nodes to scale the cluster to"
  default = 3
}

variable aks_network_vnet_resource_group {
  type        = string
  description = "Resource group of the existing VNET"
  default = null
}

variable aks_network_vnet_name {
  type        = string
  description = "Name of the existing VNET"
  default = null
}

variable aks_network_vnet_subnet_name {
  type        = string
  description = "Name of the existing subnet in existing VNET"
  default = null
}

variable aks_tags {
  type        = map(string)
  description = "Tags to apply to aks"
  default = {
    Name = "adp-simhub-petar-aks-test"
  }
}