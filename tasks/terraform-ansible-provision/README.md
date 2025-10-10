## Task #2 – Terraform multi-env + AWS EC2 + Ansible
This is part of a generic DevOps portfolio demo.

### Demonstrates
- Multi-environment Terraform structure (`envs/dev`, `envs/prod`) calling a reusable module (`modules/compute_instance`).
- Provisioning an Ubuntu EC2 instance on AWS.
- Installing Ansible on the instance and running a small demo playbook via Terraform provisioners.
Note: For demos only. In production, prefer SSM or CI-run Ansible rather than Terraform `remote-exec`.
### Structure
```text
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
### Quick start (dev)
```bash
terraform -chdir=tasks/terraform-ansible-provision/envs/dev init -backend=false
terraform -chdir=tasks/terraform-ansible-provision/envs/dev validate
terraform -chdir=tasks/terraform-ansible-provision/envs/dev plan -var 'aws_profile=default' -var 'public_key=$(cat ~/.ssh/id_rsa.pub)'
# Optional (creates real resources; costs may apply):
# terraform -chdir=tasks/terraform-ansible-provision/envs/dev apply -auto-approve -var 'aws_profile=default' -var 'public_key=$(cat ~/.ssh/id_rsa.pub)'
```
### Validation
- `terraform validate` passes.
- `terraform plan` shows EC2, SG, key pair, and provisioner resources.
### Notes
- The Ansible playbook runs on the EC2 instance using Terraform `file` + `remote-exec` provisioners.
- Minimal secret handling for brevity; rotate keys/offload to a vault in real projects.
