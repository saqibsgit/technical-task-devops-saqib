# Task #2 – Terraform multi-env + AWS EC2 + Ansible

Demonstrates:
- Multi-environment Terraform structure (`envs/dev`, `envs/prod`) calling a reusable module.
- Provisioning an Ubuntu EC2 instance on AWS.
- Installing Ansible on the instance and running a small demo playbook via Terraform provisioners.

> Note: For demos only. In production, prefer SSM or CI-run Ansible rather than Terraform `remote-exec`.

## Structure
```
tasks/terraform-ansible-provision/
├── envs/
│   ├── dev/main.tf
│   └── prod/main.tf
├── modules/
│   └── compute_instance/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── ansible/playbooks/site.yml
```

## Quick Start (dev)
```bash
cd tasks/terraform-ansible-provision/envs/dev
terraform init
terraform validate
terraform plan -var 'aws_profile=default' -var 'public_key=$(cat ~/.ssh/id_rsa.pub)'
# Optional (creates real resources, costs may apply):
# terraform apply -auto-approve -var 'aws_profile=default' -var 'public_key=$(cat ~/.ssh/id_rsa.pub)'
```

### Validation
- `terraform validate` should pass.
- `terraform plan` shows EC2, SG, key pair, and `null_resource` with provisioners.
- If applied, SSH: `ssh -i ~/.ssh/id_rsa ubuntu@<public_ip>` and `cat /tmp/ansible_hello.txt`.

### Trade-offs
- `remote-exec` is acceptable for demos but not ideal at scale.
- Minimal secret handling for brevity; rotate keys/offload to a vault in real projects.
