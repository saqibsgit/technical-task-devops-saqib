# technical-task-devops-saqib
This repository contains my solutions for three selected tasks:

- **Task #2**: Terraform multi-environment structure + AWS EC2 provisioning + Ansible bootstrap  
- **Task #4**: CI/CD pipeline (GitLab recommended; I also include GitHub Actions compatibility)  
- **Task #5**: Helm chart for WordPress (templated only; validated with `helm lint` and `--dry-run`)

> Goal: demonstrate realistic DevOps practices — modular IaC, automation, Kubernetes packaging, and clear documentation — under a 4-hour constraint.

## Repository Layout (evolves per PR)cat > .editorconfig <<'EOF'
root = true

[*]
charset = utf-8
end_of_line = lf
indent_style = space
indent_size = 2
insert_final_newline = true
trim_trailing_whitespace = true

[*.{py,yml,yaml,json,tf,tfvars}]
indent_size = 2
EOF