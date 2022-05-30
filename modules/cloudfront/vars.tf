variable "bucket-name" {
  description = "Name of S3 Bucket"
  type        = string
  default     = "bucket"
}

variable "bucket_arn" {
  description = "ARN of Bucket"
  type        = string
  default     = ""
}

variable "bucket_domain_name" {
  description = "Regional Domain name of S3 bucket"
  type        = string
  default     = ""
}

variable "region" {
  description = "Region"
  type        = string
  default     = "1.21"
}

variable "root_obj" {
  description = "Default root object for CDN"
  type        = string
  default     = "index.html"
}

variable "price_class" {
  description = "Price Class of CDN"
  type        = string
  default     = ""
}

variable "Environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "acm_certificate_arn" {
  description = "ARN of ACM certificate"
  type        = string
}

variable "domain_aliases" {
  description = "ARN of ACM certificate"
  type        = string
  default     = ""
}

locals {
  s3_origin_id = "S3-${var.bucket-name}"
}