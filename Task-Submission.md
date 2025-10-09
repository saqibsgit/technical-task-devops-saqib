# Submission Overview — DevOps Technical Task (Saqib Ali)

This repository contains my completed solutions for the **doctorly DevOps technical task**.  
I selected the following three tasks based on my strongest skills and alignment with the job’s DevOps focus.

---

## ✅ Selected Tasks

### **Task #2 – Terraform + Ansible**
- **Goal:** Demonstrate Infrastructure as Code design and configuration automation.
- **Summary:** Multi-environment Terraform project (AWS) that provisions an Ubuntu EC2 instance and bootstraps Ansible to execute a demo playbook.  
- **Highlights:**
  - Reusable Terraform module (`modules/compute_instance`).
  - Separate environments (`envs/dev`, `envs/prod`).
  - Safe validation commands (`init -backend=false`, `validate`, `plan`).
  - Demo Ansible playbook: creates `/tmp/ansible_hello.txt` on the instance.
- **Key Skills Demonstrated:** IaC modular design, cloud provisioning, Terraform–Ansible integration.

---

### **Task #4 – CI/CD Pipeline (GitHub Actions)**
- **Goal:** Build a two-stage pipeline using Docker and GitHub-hosted runners.
- **Summary:** Minimal CI/CD pipeline that builds and tests a Python CLI app inside Docker containers.
- **Highlights:**
  - **Build stage:** Builds a Docker image and uploads it as a CI artifact.
  - **Test stage:** Downloads the image and runs tests *inside the container*.
  - Uses GitHub-hosted Ubuntu runners (cloud-based service).
- **Key Skills Demonstrated:** CI/CD automation, containerized testing, artifact flow, workflow design.

---

### **Task #5 – Helm Chart for WordPress**
- **Goal:** Showcase Kubernetes packaging using Helm.
- **Summary:** A templated Helm chart for WordPress including all required Kubernetes manifests.
- **Highlights:**
  - Includes `Chart.yaml`, `values.yaml`, Deployment, Service, Secret, ConfigMap, and optional PVC.
  - Validated using `helm lint` and `helm install --dry-run --debug`.
  - Customizable parameters for DB credentials, site URL, replicas, and persistence.
- **Key Skills Demonstrated:** Kubernetes templating, Helm best practices, parameterized deployments.

---

## 🧩 How to Review Quickly

| Area | Command Summary | Validation Goal |
|------|------------------|-----------------|
| **Task #2** Terraform | `cd tasks/terraform-ansible-provision/envs/dev`<br>`terraform init -backend=false`<br>`terraform validate`<br>`terraform plan -var 'public_key=$(cat ~/.ssh/id_rsa.pub)'` | Validate IaC structure & syntax |
| **Task #4** CI/CD | CI runs automatically via GitHub Actions | Verify two-stage pipeline build → test |
| **Task #5** Helm | `cd tasks/helm-wordpress/charts/wordpress`<br>`helm lint .`<br>`helm install demo . --dry-run --debug` | Confirm chart validity and dry-run deploy |

---

## 🧠 Assumptions & Constraints
- CI uses **GitHub-hosted Ubuntu runners** as a cloud-based execution environment.  
- Terraform is validated without applying changes to avoid infrastructure costs.  
- Helm chart is validated via dry-run only, no actual cluster deployment.  
- Secrets are base64-encoded for demo purposes; in production, they would come from a vault or external secrets manager.

---

## ⚙️ Trade-offs & Future Improvements
- Terraform `remote-exec` used for demonstration; in production, I’d use AWS SSM or a configuration management pipeline.
- CI could be extended with linting, Trivy image scanning, or pre-commit hooks.
- Helm chart could include Ingress and HorizontalPodAutoscaler for real-world usage.

---

## ⏱️ Time Management
Each task was scoped to reflect **4 hours total effort**, prioritizing clarity, correctness, and completeness over unnecessary complexity.
