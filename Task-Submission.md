Submission Overview — DevOps Technical Task (Saqib Ali)
I selected three tasks aligned to the role’s DevOps focus:
✅ Selected Tasks
Task #2 — Terraform + Ansible
What: Multi-environment Terraform (AWS) that provisions an Ubuntu EC2 instance and bootstraps Ansible to run a demo playbook.
How: Reusable module (modules/compute_instance) called by envs/dev and envs/prod.
Validation:
terraform -chdir=tasks/terraform-ansible-provision/envs/dev init -backend=false
terraform -chdir=tasks/terraform-ansible-provision/envs/dev validate
terraform -chdir=tasks/terraform-ansible-provision/envs/dev plan -var 'aws_profile=default' -var 'public_key=$(cat ~/.ssh/id_rsa.pub)'
Note: The Ansible playbook runs on the instance via Terraform file + remote-exec provisioners and writes /tmp/ansible_hello.txt.
Task #4 — CI/CD (GitHub Actions)
What: Minimal two-stage pipeline (build → test) using Docker and GitHub-hosted runners.
How:
build: docker build the sample Python CLI; upload image artifact (sample-app-ci.tar).
test: download and load the artifact; run pytest inside the same container to validate runtime consistency.
Local:
cd tasks/ci-cd-pipeline/sample-app
docker build -t sample-app:local .
docker run --rm sample-app:local pytest -q tests
Task #5 — Helm (WordPress)
What: Helm chart with templated Deployment, Service, Secret, ConfigMap, optional PVC; customizable via values.yaml.
Validation:
cd tasks/helm-wordpress/charts/wordpress
helm lint .
helm install demo . --dry-run --debug
Note: Validated with lint + dry-run only; no live cluster used.
Assumptions & Trade-offs
CI: Uses GitHub-hosted Ubuntu runners (cloud-based).
IaC: Validation only (no backend or apply) to avoid resource creation and cost.
Config Mgmt: remote-exec is demo-friendly; production would use SSM or a pipeline runner.
Secrets: Helm secrets come from values for demo; production would use Vault/External Secrets.
Time Management
Kept scope tight to the 4-hour guidance while demonstrating correctness, clarity, and best practices.
