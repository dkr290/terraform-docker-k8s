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

resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/ && sudo chmod 777 noderedvol/"
  }
}


resource "random_string" "random" {
  count = local.container_count
  length  = 4
  special = false
  upper   = false
}


resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-",["nodered",random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = var.int_port
    external = var.ext_port[count.index]
  }

  volumes {
    container_path = "/data"
    host_path = "<abspath>/noderedvol"
  }
}

# to import resource or container in this case
//terraform import docker_container.nodered_container_import "docker container id"

# resource "docker_container" "nodered_container_import" {

#   name  = "unruffled_albattani"
#   image = docker_image.nodered_image.latest

# }
