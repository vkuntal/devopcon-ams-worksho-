# see https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "website" {
  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  content = templatefile("./templates/index.tftpl.html", {
    name         = local.github_owner_data.name,
    github_user  = local.github_owner_data.username,
    image        = local.github_owner_data.image,
    description  = local.github_owner_data.description,
    repositories = values(data.github_repository.main),
    theme_color  = var.website_theme_color,
    query        = local.github_owner_data.query,
  })

  filename = "${path.module}/dist/index.html"
}

# see https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "stylesheet" {
  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  content = templatefile("./templates/styles.tftpl.css", {
    theme_color = var.website_theme_color,
  })

  filename = "${path.module}/dist/styles.css"
}