
locals {
  deployment ={
    nodered = {
      image = var.image["nodered"][terraform.workspace]
    }
    influxdb = {
      image = var.image["influxdb"][terraform.workspace]
    }
  }
}

module "image" {
  source = "./image"
  for_each = local.deployment
  image_in = each.value.image
}



resource "random_string" "random" {
  count = local.container_count
  length  = 4
  special = false
  upper   = false
}


module "container"  {
  source = "./container"
  count = local.container_count
  name_in = join("-",["nodered",terraform.workspace, random_string.random[count.index].result])
  image_in = module.image["nodered"].image_out
  int_port_in = var.int_port
  ext_port_in = var.ext_port[terraform.workspace][count.index]
  container_path_in = "/data"
  

depends_on = [
  module.image
]

}

# to import resource or container in this case
//terraform import docker_container.nodered_container_import "docker container id"

# resource "docker_container" "nodered_container_import" {

#   name  = "unruffled_albattani"
#   image = docker_image.nodered_image.latest

# }

