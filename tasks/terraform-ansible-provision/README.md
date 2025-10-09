Terraform + Ansible Provisioning

This example shows a minimal setup where Terraform provisions an AWS EC2 instance via a reusable module, and Ansible has a simple demo playbook.

Structure:

- `modules/compute_instance`: Reusable Terraform module that creates an EC2 instance
- `envs/dev` and `envs/prod`: Example environments that call the module
- `ansible/playbooks/site.yml`: Demo playbook that writes a file on the target host

Prerequisites:

- Terraform installed
- AWS credentials configured in your environment (e.g., via AWS CLI)
- Ansible installed (optional, for running the playbook)

Quick start (dev environment):

1. Change directory:
   
   ```bash
   cd tasks/terraform-ansible-provision/envs/dev
   ```

2. Initialize and apply:
   
   ```bash
   terraform init
   terraform apply
   ```

3. After apply, note the `public_ip` output. To run the demo Ansible playbook, ensure the instance is reachable (e.g., proper security group allowing SSH) and you have the appropriate SSH key:

   ```bash
   cd ../../ansible
   ansible-playbook -i "<PUBLIC_IP>," -u ec2-user --private-key /path/to/key.pem playbooks/site.yml
   ```

Notes:

- The module includes basic variables such as `ami`, `instance_type`, and `instance_name`. Update values in the environment `main.tf` files as needed.
- For simplicity, networking/security groups/keys are not fully managed here; tailor to your environment.


