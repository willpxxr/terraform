resource "random_uuid" "admin" {
}

locals {
  roles = [
    {
      id = random_uuid.admin.result
      name = "admin"
      description = "Full admin rights to ArgoCD"
    }
  ]
}
