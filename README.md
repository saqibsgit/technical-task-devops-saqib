# DevOps Technical Task — Saqib Ali

This repository is a public portfolio demo of a **DevOps technical task**.  
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

## 📄 How to Navigate

- For validation and detailed setup instructions, see `Task-Submission.md`.
- Each task folder contains its own README with task-specific steps:
  - `tasks/terraform-ansible-provision/README.md`
  - `tasks/ci-cd-pipeline/README.md` (inside `sample-app`)
  - `tasks/helm-wordpress/README.md`
