## create terraform.tfvars file and add ext_port = some value
## if type is a list then tfvars will have list of port like ext_ports = [1880,1881,1802]



variable "image" {

  type = map
  description = "image for the container"
  default = {
   nodered = {
    dev = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
   influxdb = {
     dev = "quay.io/influxdb/influxdb:v2.0.2"
     prod = "quay.io/influxdb/influxdb:v2.0.2"
   }

  }

}


variable "ext_port" {
  type = map
  #sensitive = true  

  validation {
    condition = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1970
    error_message = "The external port must be in the valid port range 1970 - 65535."
  }

  validation {
    condition = max(var.ext_port["prod"]...) <= 1970 && min(var.ext_port["prod"]...) >= 1880
    error_message = "The external port must be in the valid port range 1970 - 1880."
  }
 
 

}

variable "int_port" {

   type=number
   default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "Internal port should be always 1880."
  }

}


locals {

  container_count = length(lookup(var.ext_port,terraform.workspace))

}
