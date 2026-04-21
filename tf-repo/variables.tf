variable "repository_name" {
  description = "Name of the repo"
  type        = string
}

variable "repository_description" {
  description = "Description of the repo"
  type        = string
  default     = "example repo created for tf test in devopscon"
}


variable "repository_private" {
  description = "Repo to be made private or public"
  type        = bool
  default     = false
}

variable "github_token" {
  description = "Token for github auth to create repo"
  type        = string
  sensitive   = true
}


variable "github_owner" {
  description = "Owner of the github repo"
  type        = string
  sensitive   = true
}