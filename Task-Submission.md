## Tasks Submission Overview — DevOps Technical Task (Saqib Ali)

I selected three tasks aligned to the role’s DevOps focus.

### Selected Tasks

#### Task #2 — Terraform + Ansible

- **What**: Multi-environment Terraform (AWS) that provisions an Ubuntu EC2 instance and bootstraps Ansible to run a demo playbook.
- **How**: Reusable module (`modules/compute_instance`) called by `envs/dev` and `envs/prod`.
- **Validation & usage**:

  - Prerequisites: Terraform >= 1.6, AWS CLI v2, SSH public key at `~/.ssh/id_rsa.pub`.
  - Configure AWS profile (example):
    ```bash
    aws configure --profile default
    export AWS_PROFILE=default
    ```
  - Initialize:
    ```bash
    terraform -chdir=tasks/terraform-ansible-provision/envs/dev init
    terraform -chdir=tasks/terraform-ansible-provision/envs/prod init
    ```
  - Validate:
    ```bash
    terraform -chdir=tasks/terraform-ansible-provision/envs/dev validate
    terraform -chdir=tasks/terraform-ansible-provision/envs/prod validate
    ```
  - Plan with tfvars and your SSH public key:
    ```bash
    terraform -chdir=tasks/terraform-ansible-provision/envs/dev plan \
      -var-file=dev.tfvars \
      -var "public_key=$(cat ~/.ssh/id_rsa.pub)"

    terraform -chdir=tasks/terraform-ansible-provision/envs/prod plan \
      -var-file=prod.tfvars \
      -var "public_key=$(cat ~/.ssh/id_rsa.pub)"
    ```

Note: The Ansible playbook runs on the instance via Terraform `file` + `remote-exec` provisioners and writes `/tmp/ansible_hello.txt`.

#### Task #4 — CI/CD (GitHub Actions)

- **What**: Minimal two-stage pipeline (build → test) using Docker and GitHub-hosted runners.
- **How**:
  - build: `docker build` the sample Python CLI; upload image artifact (`sample-app-ci.tar`).
  - test: download and load the artifact; run `pytest` inside the same container to validate runtime consistency.
- **Local**:

```bash
cd tasks/ci-cd-pipeline/sample-app
docker build -t sample-app:local .
docker run --rm sample-app:local pytest -q tests
```

#### Task #5 — Helm (WordPress)

- **What**: Helm chart with templated Deployment, Service, Secret, ConfigMap, optional PVC; customizable via `values.yaml`.
- **Validation**:

```bash
cd tasks/helm-wordpress/charts/wordpress
helm lint .
helm install demo . --dry-run --debug
```

Note: Validated with lint + dry-run only; no live cluster used.

### Assumptions & Trade-offs

- **CI**: Uses GitHub-hosted Ubuntu runners (cloud-based).
- **IaC**: Validation only (no backend or apply) to avoid resource creation and cost.
- **Config Mgmt**: `remote-exec` is demo-friendly; production would use SSM or a pipeline runner.
- **Secrets**: Helm secrets come from values for demo; production would use Vault/External Secrets.

### Time Management

Kept scope tight to the 4-hour guidance while demonstrating correctness, clarity, and best practices.
