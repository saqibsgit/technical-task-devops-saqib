variable "region"         { type = string }
variable "aws_profile"    { type = string }
variable "instance_type"  { type = string  default = "t3.micro" }
variable "name"           { type = string  default = "demo-ec2" }
variable "public_key"     { type = string  description = "SSH public key material (contents of id_rsa.pub)" }
variable "ansible_playbook_local_path" { type = string  default = "../../ansible/playbooks/site.yml" }

