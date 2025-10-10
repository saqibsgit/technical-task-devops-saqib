# DevOps Technical Task — Saqib Ali

This repository contains my submission for the **doctorly DevOps Engineer technical task**.  
It demonstrates practical DevOps skills across **Infrastructure as Code (Terraform + Ansible)**, **CI/CD automation (GitHub Actions)**, and **Kubernetes packaging (Helm)**.

<!-- CI badge example: replace <owner>/<repo> after you push public -->
<!-- ![CI](https://github.com/<owner>/<repo>/actions/workflows/ci.yml/badge.svg) -->

## 🚀 Selected Tasks

| # | Task | Description | Key Skills |
|---|------|-------------|-----------|
| **2** | **Terraform + Ansible** | Multi-environment Terraform (AWS) that provisions an Ubuntu EC2 instance and bootstraps Ansible to run a demo playbook. | Terraform modules, AWS IaC, Ansible provisioning |
| **4** | **CI/CD (GitHub Actions)** | Two-stage pipeline (**build → test**) that builds a Docker image and runs unit tests **inside the container**. | CI/CD design, Docker, artifacts |
| **5** | **Helm Chart (WordPress)** | Parameterized Helm chart for WordPress, validated with `helm lint` and dry-run install. | Kubernetes manifests, Helm templating |

## 🧩 Repository Structure
```text
.
├── .github/workflows/ci.yml # Task #4 — GitHub Actions pipeline
├── tasks/
│   ├── ci-cd-pipeline/ # Task #4 — Sample app + Dockerfile + README
│   │   └── sample-app/
│   ├── terraform-ansible-provision/ # Task #2 — Terraform + Ansible
│   │   ├── envs/{dev,prod}/
│   │   ├── modules/compute_instance/
│   │   └── ansible/playbooks/site.yml
│   └── helm-wordpress/ # Task #5 — Helm chart for WordPress
│       └── charts/wordpress/
├── Task-Submission.md # Reviewer one-pager
└── README.md
```

## 🧪 Quick Local Validation

### Task #2 – Terraform + Ansible
```bash
terraform -chdir=tasks/terraform-ansible-provision/envs/dev init -backend=false
terraform -chdir=tasks/terraform-ansible-provision/envs/dev validate
terraform -chdir=tasks/terraform-ansible-provision/envs/dev plan -var 'aws_profile=default' -var 'public_key=$(cat ~/.ssh/id_rsa.pub)'
# Optional: apply will create real AWS resources and incur cost
# terraform -chdir=tasks/terraform-ansible-provision/envs/dev apply -auto-approve -var 'aws_profile=default' -var 'public_key=$(cat ~/.ssh/id_rsa.pub)'
```

### Task #4 – CI/CD (GitHub Actions, minimal)
```bash
cd tasks/ci-cd-pipeline/sample-app
docker build -t sample-app:local .
docker run --rm sample-app:local                  # prints 5
docker run --rm sample-app:local pytest -q tests  # run tests INSIDE the container (matches CI)
```

### Task #5 – Helm (WordPress)
```bash
cd tasks/helm-wordpress/charts/wordpress
helm lint .
helm install demo . --dry-run --debug
```

### CI/CD Details (Task #4)
The pipeline (`.github/workflows/ci.yml`) has two jobs:
- build → builds a Docker image and uploads it as an artifact (`sample-app-ci.tar`).
- test → downloads that artifact, loads the image, and runs pytest inside the container.
- Runs on GitHub-hosted Ubuntu runners (cloud-based).
 
### Assumptions
- Terraform validation avoids using a backend or applying resources.
- Helm validation uses lint and dry-run only; no cluster required.
- Docker-based pipeline ensures reproducible build and test environments.
 
### Notes for Reviewers
- Each task folder contains its own README with setup and validation steps.
- The repository follows structured commits/PRs and standard hygiene (`.editorconfig`, `.gitignore`, PR template).
