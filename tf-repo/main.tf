resource "github_repository" "repo_devops" {
  name        = var.repository_name
  description = var.repository_description
  visibility  = var.visibility
}