############################
# Variables de configuración
############################

variable "prefix" {
  description = "Prefijo para nombrar recursos"
  type        = string
  default     = "assessment-devops"
}

variable "location" {
  description = "Región de Azure (ej: brazilsouth, eastus)"
  type        = string
  default     = "eastus2"
}

variable "address-space-vnet" {
  description = "vnet cidr"
  type        = string
  default     = "10.55.0.0/16"
}

variable "address-space-snet-aks" {
  description = "snet cidr"
  type        = string
  default     = "10.55.1.0/24"
}

variable "address-space-snet-ingress" {
  description = "snet cidr"
  type        = string
  default     = "10.55.2.0/24"
}

variable "node_count" {
  description = "Número de nodos del pool por defecto"
  type        = number
  default     = 2
}
variable "vm_size" {
  description = "Tamaño de VM de los nodos"
  type        = string
  default     = "Standard_D2s_v3" # "Standard_DS2_v2"
}
variable "env" {
  description = "ambiente"
  type        = string
  default     = "prod"
}

variable "name_acr" {
  description = "nombre del acr"
  type        = string
  default     = "acrassessmentdevops"
}
