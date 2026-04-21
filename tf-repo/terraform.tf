terraform {

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.11"
    }

    # see https://registry.terraform.io/providers/hashicorp/local/2.8.0
    local = {
      source  = "hashicorp/local"
      version = ">= 2.8.0, < 3.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/time/latest
    time = {
      source  = "hashicorp/time"
      version = ">= 0.12.0, < 1.0.0"
    }
  }

    # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
       required_version = ">= 1.14.0, < 2.0.0"
  
}

