variable "version" {
  description = "Version of Kubernetes"
  type        = string
  default     = "1.21"
}

variable "subnet_ids" {
  description = "CIDRs of Subnets for EKS"
  type        = list(string)
}

variable "endpoint_private_access" {
  description = "Should be true to enable private access of K8s API server"
  type        = bool
  default     = true
}

variable "endpoint_public_access"{
  description = "Should be true to enable public access of K8s API server"
  type        = bool
  default     = true
}

variable "node_group_desired_size" {
  description = "Scaling Configuration --> Size of Node Group"
  type        = number
  default     = 2
}

variable "node_group_max_size" {
  description = "Scaling Configuration --> Maximum instances in Node Group"
  type        = number
  default     = 4
}

variable "node_group_min_size" {
  description = "Scaling Configuration --> Minimum instances in Node Group"
  type        = number
  default     = 2
}

variable "node_group_ami_type" {
  description = "Machine Image of Nodes"
  type        = string
  default     = "AL2_x86_64"
  validation {
    condition = (
      contains(["AL2_x86_64", "AL2_x86_64_GPU", "AL2_ARM_64", "BOTTLEROCKET_x86_64", "BOTTLEROCKET_ARM_64", "CUSTOM"], var.ami_type)
    )
    error_message = "Variable ami_type must be one of \"AL2_x86_64\", \"AL2_x86_64_GPU\", \"AL2_ARM_64\", \"BOTTLEROCKET_x86_64\", \"BOTTLEROCKET_ARM_64\", or \"CUSTOM\"."
  }
}

variable "node_group_capacity_type" {
  description = "Capacity Requirement of Nodes"
  type        = string
  default     = "ON_DEMAND"
}

variable "node_group_disk_size" {
  description = "Disk Size of Nodes"
  type        = number
  default     = 5
}

variable "node_group_instance_types" {
  description = "Instance Types of Nodes"
  type        = list(string)
  default     = ["t3.large"]
}

variable "node_group_labels" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "project_naming"{
  description = "Project Name"
  type        = string
  default     = ""
}