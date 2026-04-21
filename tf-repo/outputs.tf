output "github_repositories_list" {
  description = "Exported List of Repositories of the `github_repositories.main` Data Source."
  value       = data.github_repositories.main
  sensitivie = true
}

output "github_repositories" {
  description = "Exported Attributes of the `github_repository.main` Data Source."
  value       = data.github_repository.main
}

# Option 1: Personal GitHub Account
# uncomment and use this output if you are retrieving projects stored under a personal GitHub Account
output "github_user" {
  description = "Exported Attributes of the `github_user.main` Data Source."
  value       = data.github_user.main
  sensitive = true
}

# Option 2: GitHub Organization
# uncomment and use this output if you are retrieving projects stored under a GitHub Organization
#output "github_organization" {
#  description = "Exported Attributes of the `github_organization.main` Data Source."
#  value       = data.github_organization.main
#}