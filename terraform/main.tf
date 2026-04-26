resource "kubernetes_namespace_v1" "gitops" {
    metadata {
        name = "gitops"
    }
}

resource "helm_release" "argocd" {
  name = "argocd"
  namespace = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"

  create_namespace = true
}

resource "kubernetes_manifest" "gitops_engine" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
        name = "gitops-engine"
        namespace = "argocd"
    }

    spec = {
        project = "default"

        source = {
            repoURL     = "https://github.com/cotishq/gitops-engine"
            targetRevision = "main"
            path = "gitops-chart"
        }

        destination = {
            server = "https://kubernetes.default.svc"
            namespace = "gitops"
        }

        syncPolicy = {
            automated = {
                prune = true
                selfHeal = true
            }
        }
    }
  }
}