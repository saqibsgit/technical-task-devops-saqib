# DevOps Technical Task — Saqib Ali

This repository contains my submission for the **doctorly DevOps Engineer technical task**.  
It demonstrates practical DevOps skills across **Infrastructure as Code**, **CI/CD automation**, and **Kubernetes packaging**.

---

## 🚀 Selected Tasks

| # | Task | Description | Key Skills |
|---|------|--------------|-------------|
| **2** | **Terraform + Ansible** | Multi-environment Terraform project that provisions an Ubuntu EC2 instance and bootstraps Ansible to run a demo playbook. | Terraform modules, AWS IaC, Ansible provisioning |
| **4** | **CI/CD (GitHub Actions)** | Two-stage pipeline (**build → test**) that builds a Docker image and runs unit tests inside the container. | CI/CD design, Docker, automation |
| **5** | **Helm Chart (WordPress)** | Parameterized Helm chart for WordPress, validated with `helm lint` and dry-run deployment. | Kubernetes manifests, Helm templating |

---

## 🧩 Repository Structure

```
.
├── .github/workflows/ci.yml # Task #4 — GitHub Actions pipeline
├── tasks/
│ ├── terraform-ansible-provision/ # Task #2 — Terraform + Ansible
│ │ ├── envs/{dev,prod}/
│ │ ├── modules/compute_instance/
│ │ └── ansible/playbooks/site.yml
│ ├── ci-cd-pipeline/ # Task #4 — Sample app + Dockerfile + README
│ │ └── sample-app/
│ └── helm-wordpress/ # Task #5 — Helm chart for WordPress
│   └── charts/wordpress/
├── SUBMISSION.md # Reviewer summary and validation guide
└── README.md
```

---

## 🧪 Quick Local Validation

### Task #2 – Terraform + Ansible
```bash
cd tasks/terraform-ansible-provision/envs/dev
terraform init -backend=false
terraform validate
terraform plan -var 'public_key=$(cat ~/.ssh/id_rsa.pub)'
```

### Task #4 – CI/CD (Sample App)
```bash
cd tasks/ci-cd-pipeline/sample-app
docker build -t sample-app:local .
docker run --rm sample-app:local             # prints 5
docker run --rm sample-app:local pytest -q   # runs tests inside container
```

### Task #5 – Helm (WordPress)
```bash
cd tasks/helm-wordpress/charts/wordpress
helm lint .
helm install demo . --dry-run --debug
```

### CI/CD Details (Task #4)
- Build → builds a Docker image and uploads it as an artifact.
- Test → downloads that artifact and runs tests inside the container.
- Runs on GitHub-hosted Ubuntu runners, fulfilling the “cloud-based CI/CD” requirement.

### Assumptions
- Terraform validation avoids backend initialization or actual applies.
- Helm validation runs locally or via CI without deploying to Kubernetes.
- Docker-based pipeline ensures reproducible build and test environments.

### Notes for Reviewers
- Each task folder includes its own README.md with detailed setup and validation steps.
- The repository follows standard DevOps structure and commit discipline (feat/, docs/, chore/ prefixes).
- CI pipeline automatically verifies build + test correctness.


