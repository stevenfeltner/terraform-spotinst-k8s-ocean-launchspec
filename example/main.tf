#Can move these to variables
locals {
  spotinst_token = ""
  spotinst_account = "act-12345"
  cluster_name = "EKS-Workshop"
}

## Create Ocean Virtual Node Group (launchspec) ##
module "ocean_eks_launchspec_stateless" {
  source = "../k8s-ocean-launchspec"

  # Spot.io Credentials
  spotinst_token              = local.spotinst_token
  spotinst_account            = local.spotinst_account

  cluster_name = local.cluster_name
  ocean_id = module.k8s-ocean.ocean_id

  # Name of VNG in Ocean
  name = "stateless"
  # Can change the AMI
  #ami_id = ""
  # Add Labels or taints
  labels = [{key="type",value="stateless"}]
  #taints = [{key="type",value="stateless",effect="NoSchedule"}]
  tags = [{key = "CreatedBy", value = "terraform"}]
}

## Create additional Ocean Virtual Node Group (launchspec) ##
module "ocean_eks_launchspec_gpu" {
  source = "../"

  # Spot.io Credentials
  spotinst_token              = local.spotinst_token
  spotinst_account            = local.spotinst_account

  cluster_name = local.cluster_name
  ocean_id = module.k8s-ocean.ocean_id

  # Name of VNG in Ocean
  name = "gpu"
  # Can change the AMI
  #ami_id = ""
  # Add Labels or taints
  labels = [{key="type",value="gpu"}]
  taints = [{key="type",value="gpu",effect="NoSchedule"}]
  # Limit VNG to specific instance types
  #instance_types = ["g4dn.xlarge","g4dn.2xlarge"]
  # Change the spot %
  #spot_percentage = 50
}

## Outputs ##
output "virtual_node_group_gpu_id" {
  value = module.ocean_eks_launchspec_gpu.virtual_node_group_id
}
output "virtual_node_group_stateless_id" {
  value = module.ocean_eks_launchspec_stateless.virtual_node_group_id
}
