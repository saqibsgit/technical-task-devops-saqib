terraform {
  required_providers {
    aws  = { source = "hashicorp/aws", version = "~> 5.0" }
    null = { source = "hashicorp/null", version = "~> 3.0" }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

// AMI is now provided via variable to avoid needing AWS lookups during planning

resource "aws_key_pair" "this" {
  key_name   = "${var.name}-key"
  public_key = var.public_key
}

resource "aws_security_group" "this" {
  name        = "${var.name}-sg"
  description = "Allow SSH"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.this.key_name
  vpc_security_group_ids = [aws_security_group.this.id]
  tags                   = { Name = var.name }
}

# Copy playbook and run Ansible on the instance (demo-only)
resource "null_resource" "ansible_bootstrap" {
  depends_on = [aws_instance.this]

  provisioner "file" {
    source      = var.ansible_playbook_local_path
    destination = "/home/ubuntu/site.yml"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.this.public_ip
      private_key = file(pathexpand(var.ssh_private_key_path))
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y software-properties-common",
      "sudo apt-get update -y",
      "sudo apt-get install -y ansible",
      "echo 'localhost' > /home/ubuntu/hosts",
      "ansible -i /home/ubuntu/hosts all -m ping || true",
      "ansible-playbook -i /home/ubuntu/hosts /home/ubuntu/site.yml || true"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.this.public_ip
      private_key = file(pathexpand(var.ssh_private_key_path))
    }
  }
}