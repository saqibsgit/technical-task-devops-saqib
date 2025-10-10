terraform {
  required_version = ">= 1.6.0"
}

variable "region"      { type = string  default = "eu-central-1" }
variable "aws_profile" { type = string  default = "default" }
variable "public_key"  { type = string }

module "ec2" {
  source       = "../../modules/compute_instance"
  region       = var.region
  aws_profile  = var.aws_profile
  name         = "demo-dev-ec2"
  public_key   = var.public_key
}

output "public_ip" { value = module.ec2.public_ip }

