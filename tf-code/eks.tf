# module "eksCluster" {
#   source          = "../modules/EKS"

#   project_naming  = local.naming

#   subnet_ids    = module.eks_vpc.private_subnet_id
#   endpoint_public_access  = true
#   endpoint_private_access = true

#   node_group_desired_size   = 2
#   node_group_max_size       = 4
#   node_group_min_size       = 2
#   node_group_instance_types = ["t3.large"]
# }
