terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }

  user_data = <<-EOT
              #!/bin/bash
              # Minimal bootstrap suitable for Amazon Linux 2
              yum update -y
              yum install -y python3
              echo "Terraform provisioned $(date)" > /tmp/tf_bootstrap.txt
              EOT
}

output "instance_id" {
  description = "ID of the created instance"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IP of the created instance"
  value       = aws_instance.this.public_ip
}

