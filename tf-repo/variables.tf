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
  defalut     = false
}