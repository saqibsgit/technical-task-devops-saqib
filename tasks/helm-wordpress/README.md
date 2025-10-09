# Task #5 – Helm Chart for WordPress

This chart templates the Kubernetes resources to deploy WordPress (without actually deploying).
It supports customizable values for DB connection, site URL, replicas, and resources.

## Validate & Test
```bash
cd tasks/helm-wordpress/charts/wordpress
helm lint .
helm template demo . --values values.yaml | head -n 50
helm install demo . --dry-run --debug
