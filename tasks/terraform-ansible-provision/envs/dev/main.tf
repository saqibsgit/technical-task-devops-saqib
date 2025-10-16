terraform {
  required_version = ">= 1.6.0"
}

module "ec2" {
  source      = "../../modules/compute_instance"
  region      = var.region
  aws_profile = var.aws_profile
  name        = "demo-dev-ec2"
  public_key  = var.public_key
  ami_id      = var.ami_id
}



