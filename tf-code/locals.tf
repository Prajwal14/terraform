locals {

#General Naming Structure - org-project-env-resource-count
  naming = "${var.org}-${var.project}-${var.env}"

#tags
  required_tags = {
    project     = var.project,
    environment = var.env
  }
  tags = local.required_tags
}