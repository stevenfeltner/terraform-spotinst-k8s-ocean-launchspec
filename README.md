# terraform-spotinst-k8s-ocean-launchspec

Spotinst Terraform Module to integrate existing k8s node groups with Ocean launchspec/Virtual Node group (VNG)


##Usage
```hcl
## Create Ocean Virtual Node Group (launchspec) ##
module "ocean_eks_launchspec_stateless" {
  source = "stevenfeltner/k8s-ocean-launchspec/spotinst"

  # Spot.io Credentials
  spotinst_token              = local.spotinst_token
  spotinst_account            = local.spotinst_account

  cluster_name = local.cluster_name
  ocean_id = module.ocean_eks.ocean_id

  # Name of VNG in Ocean
  name = "stateless"
  # Can change the AMI
  #ami_id = ""
  # Add Labels or taints
  labels = [{key="type",value="stateless"}]
  #taints = [{key="type",value="stateless",effect="NoSchedule"}]
  tags = [{key = "CreatedBy", value = "stevenfeltner"}]
}

## Create additional Ocean Virtual Node Group (launchspec) ##
module "ocean_eks_launchspec_gpu" {
  source = "stevenfeltner/k8s-ocean-launchspec/spotinst"
  # Spot.io Credentials
  spotinst_token              = local.spotinst_token
  spotinst_account            = local.spotinst_account

  cluster_name = local.cluster_name
  ocean_id = module.ocean_eks.ocean_id

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
  spot_percentage = 0
}
```