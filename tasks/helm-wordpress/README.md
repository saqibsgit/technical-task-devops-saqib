Task #5 – Helm Chart for WordPress
Templates Kubernetes resources to deploy WordPress (without actually deploying).
Supports customization of DB connection, site URL, replicas, and persistence via values.yaml.
Validate & Test
cd tasks/helm-wordpress/charts/wordpress
helm lint .
helm template demo . --values values.yaml | head -n 50
helm install demo . --dry-run --debug
Notes
Secrets are generated from values (base64 encoded by Helm). For production, prefer external Secret management (e.g., External Secrets + Vault/SM).
This minimal chart excludes Ingress and HPA for simplicity but can be extended easily if needed.
