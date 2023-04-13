variable "region" {
  default     = "europe-west2"
  description = "London Region"
}

variable "project_id" {
  description = "Project ID"
}

variable "vpc" {
  default     = "vpc-k8-cluster"
  description = "Name of VPC network"
}

variable "subnet_name" {
  default     = "k8-private-subnet"
  description = "Name of VPC subnet"
}

variable "my_gke_cluster" {
  default     = "my-gke-cluster"
  description = "GKE cluster Name"
}

variable "subnet_cidr_block" {
  default     = "10.1.0.0/16"
  description = "subnet CIDR block /16 "
}

variable "master_cidr_block" {
  default     = "10.100.0.0/28"
  description = "master nodes range "
}

variable "service_cidr_block" {
  default     = "172.31.0.0/16"
  description = "kubernetes services range "
}

variable "pod_cidr_block" {
  default     = "172.32.0.0/16"
  description = "pods ranges "
}