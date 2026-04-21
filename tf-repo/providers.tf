provider "github" {
   token        = var.github_token
   owner        = var.github_owner 
}

# see https://registry.terraform.io/providers/hashicorp/local/latest/docs
provider "local" {}