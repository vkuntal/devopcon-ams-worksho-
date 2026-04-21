resource "github_repository" "repo_devops" {
  name        = var.repository_name
  description = var.repository_description
  visibility  = var.visibility
}

# see https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/user
data "github_user" "main" {
  username = var.github_owner
}

locals {
  # Option 1: Personal GitHub Account
  # uncomment and use this object if you are retrieving projects stored under a personal GitHub Account
  github_owner_data = {
    description = data.github_user.main.bio
    image       = data.github_user.main.avatar_url
    name        = data.github_user.main.name
    query       = "user:${data.github_user.main.username}"
    username    = data.github_user.main.username
  }

  # Option 2: GitHub Organization
  # uncomment and use this object if you are retrieving projects stored under a GitHub Organization
  # then comment the `github_owner_data` object of "Option 1" above
  # github_owner_data = {
  #   description = data.github_organization.main.description
  #   name        = data.github_organization.main.name
  #   query       = "org:${data.github_organization.main.orgname}"
  #   username    = data.github_organization.main.orgname
  # }

  # change "is:public" to "is:private" if you intend to showcase private projects
  # change "archived:false" to "archived:true" if you intend to showcase archived projects
  github_api_query = "${local.github_owner_data.query} is:public archived:false"
}

# get all repositories for the GitHub Organization
# see https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repositories
data "github_repositories" "main" {
  # find all repositories that are specific to this organization and are publicly available
  # see https://docs.github.com/search-github/searching-on-github/searching-for-repositories
  query = local.github_api_query
}

# iterate over ALL repositories from the `data.github_repositories` data source and retrieve more information
# see https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository
data "github_repository" "main" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = toset(data.github_repositories.main.full_names)

  full_name = each.key
}

# see https://registry.terraform.io/providers/integrations/github/6.11.1/docs/resources/repository
resource "github_repository" "main" {
  name        = "${var.github_owner}.github.io"
  description = "Terraform made this website for me!"

  visibility = "public"
  auto_init  = true

  pages {
    source {
      branch = "main"
      path   = "/"
    }
  }
}

# Wait for the auto-init commit on `main` to propagate before writing files
# or letting Pages try to build — avoids the 422 "main branch must exist
# before GitHub Pages can be built" race.
resource "time_sleep" "wait_for_branch" {
  depends_on      = [github_repository.main]
  create_duration = "15s"
}

# see https://registry.terraform.io/providers/integrations/github/6.11.1/docs/resources/repository_file
resource "github_repository_file" "main" {
  for_each = {
    "index.html" = local_file.website.content
    "styles.css" = local_file.stylesheet.content
  }

  depends_on = [time_sleep.wait_for_branch]

  repository = github_repository.main.name
  branch     = "main"

  file    = each.key
  content = each.value

  commit_message      = "Managed by Terraform"
  commit_author       = var.github_owner
  commit_email        = "noreply@github.com"
  overwrite_on_create = true
}