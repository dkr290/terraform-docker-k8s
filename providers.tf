terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.12"
    }
  }
}

# download nodered image

provider "docker" {}