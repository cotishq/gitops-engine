# GitOps Engine — End-to-End DevOps Pipeline

A fully automated GitOps + Infrastructure-as-Code pipeline that deploys a Go backend to Kubernetes using Helm and ArgoCD, provisioned via Terraform.

---

## Overview

This project demonstrates a complete DevOps workflow:

```
Terraform → Kubernetes → ArgoCD → Helm → Application
```

* Infrastructure is provisioned using Terraform
* ArgoCD is installed via Helm (through Terraform)
* Application is deployed using GitOps principles
* Every Git push automatically triggers a deployment

---

## Tech Stack

* Go (Backend Service)
* Docker (Containerization)
* Kubernetes (Orchestration)
* Helm (Packaging)
* ArgoCD (GitOps Continuous Delivery)
* Terraform (Infrastructure as Code)

---

## Project Structure

```
gitops-engine/
│
├── app/                # Go backend + Dockerfile
├── k8s/                # Raw Kubernetes manifests (initial)
├── gitops-chart/       # Helm chart for the app
├── terraform/          # Terraform configs (ArgoCD + infra)
└── README.md
```

---

## Workflow

1. Developer pushes code to GitHub
2. ArgoCD detects changes in repo
3. Helm chart is re-applied
4. Kubernetes updates the deployment
5. New version goes live automatically

---

## Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/cotishq/gitops-engine
cd gitops-engine/terraform
```

---

### 2. Apply Terraform

```bash
terraform init
terraform apply
```

This will:

* Create Kubernetes resources
* Install ArgoCD
* Deploy the application automatically

---

### 3. Access ArgoCD UI

```bash
kubectl port-forward svc/argocd-server -n argocd 9091:80
```

Open:

```
http://localhost:9091
```

Get password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d
```

---

### 4. Access Application

```bash
kubectl port-forward svc/gitops-service 9090:80 -n gitops
```

Open:

```
http://localhost:9090
```

---

## GitOps in Action

Update the app version:

```yaml
tag: v2
```

Then:

```bash
docker build -t cotishq/gitops-engine:v2 ./app
docker push cotishq/gitops-engine:v2
git commit -am "update version"
git push
```

ArgoCD will automatically sync and deploy the new version.

---

## Architecture

```
         +-------------------+
         |    Terraform      |
         +--------+----------+
                  |
                  v
         +-------------------+
         |   Kubernetes      |
         +--------+----------+
                  |
                  v
         +-------------------+
         |     ArgoCD        |
         +--------+----------+
                  |
                  v
         +-------------------+
         |      Helm         |
         +--------+----------+
                  |
                  v
         +-------------------+
         |   Go Application  |
         +-------------------+
```

---

## Features

* Fully automated deployments via GitOps
* Infrastructure managed with Terraform
* Helm-based application packaging
* Self-healing and auto-sync via ArgoCD
* Versioned container deployments

---

## Future Improvements

* Terraform provisioning for AWS EKS
* Ingress for public access
* Monitoring (Prometheus + Grafana)

---

## Key Learnings

* Handling Kubernetes resource conflicts (CRDs, ClusterRoles)
* Managing state between Terraform and Helm
* Debugging ArgoCD sync issues
* Implementing real-world GitOps workflows

---

## ⭐ If you found this useful, give it a star!

