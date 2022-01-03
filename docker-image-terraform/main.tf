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



resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}


resource "random_string" "random" {
  count = 1
  length  = 4
  special = false
  upper   = false
}


resource "docker_container" "nodered_container" {
  count = 1
  name  = join("-",["nodered",random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = "1880"
    #external = "1880"
  }
}

# to import resource or container in this case
//terraform import docker_container.nodered_container_import "docker container id"

# resource "docker_container" "nodered_container_import" {

#   name  = "unruffled_albattani"
#   image = docker_image.nodered_image.latest

# }

