## create terraform.tfvars file and add ext_port = some value
## if type is a list then tfvars will have list of port like ext_ports = [1880,1881,1802]

variable "ext_port" {
  type = list
  #sensitive = true

  #validation {
  #  condition = var.ext_port <= 65535 && var.ext_port > 0
  #  error_message = "The external port must be in the valid port range 0 - 65535."
  #}


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

  container_count = length(var.ext_port)

}
