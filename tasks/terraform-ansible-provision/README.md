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
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── dev.tfvars
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── prod.tfvars
├── modules/
│   └── compute_instance/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── ansible/playbooks/site.yml
```

### Prerequisites
- Terraform >= 1.6
- AWS CLI v2 installed and authenticated
- An existing SSH public key on your machine (defaults assumed at `~/.ssh/id_rsa.pub`)

### Configure an AWS CLI profile locally
1) Create or update `~/.aws/credentials` and `~/.aws/config` via AWS CLI:
```bash
aws configure --profile default
```
Provide access key, secret, default region (e.g., `eu-central-1`), and output format.

2) Or edit files directly:
```ini
# ~/.aws/credentials
[demo]
aws_access_key_id=YOUR_ACCESS_KEY_ID
aws_secret_access_key=YOUR_SECRET_ACCESS_KEY

# ~/.aws/config
[profile demo]
region=eu-central-1
output=json
```

3) Export the profile for Terraform/CLI sessions (optional):
```bash
export AWS_PROFILE=default
```

The Terraform configs accept a variable `aws_profile` that is passed into the module; you can also rely on `AWS_PROFILE` if your local env is set accordingly.

### Input variables and tfvars
Each environment comes with a `*.tfvars` file specifying non-sensitive defaults:
- `envs/dev/dev.tfvars`
- `envs/prod/prod.tfvars`

Variables used by environments:
- `region` (string, default `eu-central-1`)
- `aws_profile` (string, default `default`)
- `ami_id` (string, placeholder – replace with a valid AMI for your region)
- `public_key` (string, required) – your SSH public key content. This is not in the committed tfvars; supply it at runtime as shown below.

#### What to put in dev.tfvars and prod.tfvars
These environment files are created locally and are not pushed to the remote repository (Terraform best practice: keep per-user/per-env overrides and any sensitive data out of VCS). Ensure your `.gitignore` excludes `*.tfvars` under this task directory.

Recommended keys for both files:
- `region`: AWS region for the environment
- `aws_profile`: Local AWS CLI profile name you want Terraform to use
- `ami_id`: AMI ID valid for the selected region
  
Optional (override module defaults if desired):
- `instance_type`: EC2 instance type (module default: `t3.micro`)
- `name`: Base name/tag for resources (module default: `demo-ec2`)

Example `envs/dev/dev.tfvars`:
```hcl
region      = "eu-central-1"
aws_profile = "default"
ami_id      = "ami-0abcdef1234567890" # replace with a valid Ubuntu AMI in region

# Optional overrides
# instance_type = "t3.small"
# name          = "dev-ec2"
```

Example `envs/prod/prod.tfvars`:
```hcl
region      = "eu-central-1"
aws_profile = "prod"
ami_id      = "ami-0abcdef1234567890" # replace with a hardened/approved AMI

# Optional overrides
# instance_type = "t3.medium"
# name          = "prod-ec2"
```

### Initialize
Use `-chdir` to run Terraform from the project root while targeting a specific env directory.
```bash
# Dev
terraform -chdir=tasks/terraform-ansible-provision/envs/dev init

# Prod
terraform -chdir=tasks/terraform-ansible-provision/envs/prod init
```

### Validate
```bash
terraform -chdir=tasks/terraform-ansible-provision/envs/dev validate
terraform -chdir=tasks/terraform-ansible-provision/envs/prod validate
```

### Plan with tfvars
Pass the environment tfvars file and your SSH public key at runtime. You may also override the `aws_profile` to match your configured profile (e.g., `demo`).
```bash
# Dev plan
terraform -chdir=tasks/terraform-ansible-provision/envs/dev plan \
  -var-file=dev.tfvars \
  -var "public_key=$(cat ~/.ssh/id_rsa.pub)"

# Prod plan
terraform -chdir=tasks/terraform-ansible-provision/envs/prod plan \
  -var-file=prod.tfvars \
  -var "public_key=$(cat ~/.ssh/id_rsa.pub)"
```

### Notes
- The Ansible playbook runs on the EC2 instance using Terraform `file` + `remote-exec` provisioners.
- Replace the placeholder `ami_id` values in tfvars or variables with a valid AMI in your region.
- Minimal secret handling for brevity; for production, use a secrets manager and SSM Session Manager instead of direct SSH.
