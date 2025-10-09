# technical-task-devops-saqib
This repository contains my solutions for three selected tasks:

- **Task #2**: Terraform multi-environment structure + AWS EC2 provisioning + Ansible bootstrap  
- **Task #4**: CI/CD pipeline (GitLab recommended; I also include GitHub Actions compatibility)  
- **Task #5**: Helm chart for WordPress (templated only; validated with `helm lint` and `--dry-run`)

> Goal: demonstrate realistic DevOps practices — modular IaC, automation, Kubernetes packaging, and clear documentation — under a 4-hour constraint.

## Repository Layout
```
.
├── tasks/
│   └── helm-wordpress/
│       ├── README.md
│       └── charts/
│           └── wordpress/
│               ├── Chart.yaml
│               ├── values.yaml
│               └── templates/
│                   ├── deployment.yaml
│                   ├── service.yaml
│                   ├── secret.yaml
│                   ├── configmap.yaml
│                   ├── pvc.yaml
│                   └── _helpers.tpl
├── .github/
│   └── pull_request_template.md
├── .editorconfig
├── .gitignore
├── CONTRIBUTING.md
└── README.md
```
## Task #5 – Helm Chart Validation

This chart templates a WordPress application and can be verified locally without deployment:

```bash
cd tasks/helm-wordpress/charts/wordpress
helm lint .
helm template demo . --values values.yaml | head -n 30
helm install demo . --dry-run --debug
