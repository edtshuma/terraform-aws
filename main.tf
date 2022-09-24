#--root/main.tf---

module "identity" {
  source = "./identity"
  name   = "administrators"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

module "networking" {
  source   = "./networking"
  vpc_cidr = local.vpc_cidr
  max_subnets      = 20
  public_sn_count = 1
  #even numbers for public subnets
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  
  # public_cidrs   = "${cidrsubnet(local.vpc_cidr, 8, 2)}"
}