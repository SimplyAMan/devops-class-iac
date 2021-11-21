terraform {
  backend "remote" {
    organization = "devops-class"

    workspaces {
      name = "devops-lesson12"
    }
  }
}