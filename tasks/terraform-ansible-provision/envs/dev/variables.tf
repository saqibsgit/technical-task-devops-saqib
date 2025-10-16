variable "region" {
  type    = string
  default = "eu-central-1"
}
variable "aws_profile" {
  type    = string
  default = "default"
}
variable "public_key" {
  type = string
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use for this environment"
  default     = "ami-0123456789abcdef0" // placeholder
}