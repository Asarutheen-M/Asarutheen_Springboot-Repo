# HDFC_APP – Spring Boot CI/CD

Flow: Dev -> GitHub -> (Webhook) Jenkins -> Maven -> Terraform -> Ansible -> ECR -> Kubernetes (4 pods) -> Users
Monitoring: Prometheus + Grafana -> Alertmanager -> Admin email

## Layout
- `src/`, `pom.xml` – Spring Boot app (with Actuator + Prometheus metrics)
- `Dockerfile` – container image
- `Jenkinsfile` – pipeline (Maven, Terraform, Ansible)
- `terraform/` – ECR repo + EKS cluster (copy `terraform.tfvars.example` to `terraform.tfvars`)
- `ansible/` – build/push image to ECR and deploy to EKS
- `k8s/` – Deployment (4 replicas) + Service
- `monitoring/` – Prometheus, alert rules, Alertmanager (email)

## Run locally
    mvn spring-boot:run
    curl localhost:8080/api/hello
