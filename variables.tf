# A Terraform module to create a subset of cloud components
# Copyright (C) 2022 Skaylink GmbH

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For questions and contributions please contact info@iq3cloud.com


variable "resourcegroup" {
  type        = string
  description = "The resource group where the aks will be located in"
}

variable "name" {
  type        = string
  description = "name of the AKS cluster"
}

variable "authorized_ip_ranges" {
  type        = list(string)
  description = "authorized IP ranges for the AKS cluster"
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "enable public network access for the AKS cluster"
}

variable "use_managed_identity" {
  type        = bool
  description = "Toggles wether the AKS is built using a managed identity (true) or a Service Principal to authenticate within Azure Cloud (false)"
}

variable "aks_subnet_id" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "key_vault_id" {
  type = string
}

variable "aks_configuration" {
  description = "Defines AKS performance and size parameters"
  type = object({
    vm_size                        = string
    os_disk_size_gb                = number
    kubernetes_node_count          = number
    kubernetes_min_node_count      = number
    kubernetes_max_node_count      = number
    kubernetes_enable_auto_scaling = bool
    network_plugin                 = string
    max_pods                       = number
    network_policy                 = string
    kubernetes_version             = string
  })
  default = {
    kubernetes_enable_auto_scaling = false
    kubernetes_max_node_count      = null
    kubernetes_min_node_count      = null
    kubernetes_node_count          = 2
    kubernetes_version             = "1.23.5"
    max_pods                       = 30
    network_plugin                 = "azure"
    network_policy                 = "azure"
    os_disk_size_gb                = 128
    vm_size                        = "Standard_D2s_v5"
  }
}

variable "aks_node_authentication" {
  description = "SSH Information to access node pool vms"
  type = object({
    node_admin_username   = string
    node_admin_ssh_public = string
  })
}

variable "aks_addons" {
  description = "Defines which addons will be activated."
  type = object({
    aks_log_analytics_workspace_id   = string
    aks_log_analytics_workspace_name = string
    enable_kubernetes_dashboard      = bool
    enable_azure_policy              = bool
  })
  default = {
    aks_log_analytics_workspace_id   = ""
    aks_log_analytics_workspace_name = ""
    enable_kubernetes_dashboard      = false
    enable_azure_policy              = false
  }
}
variable "ingress_controller" {
  type        = bool
  default     = false
  description = "Set this value to true if you want to use an ingress controller"
}

variable "argo_cd" {
  type        = bool
  default     = false
  description = "set this value to true if you want to use Argo CD"
}

variable "ip_domain_name_label" {
  type    = string
  default = null
}

variable "aks_public_ip_labels" {
  type    = list(string)
  default = null
}
