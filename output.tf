#Output the IP Address of the Container
# output "container_name" {
#   value       = module.container[*].container_name
#   description = "The name"

# }


# output "container_ip_port" {

#   value = flatten(module.container[*].container_ip_port)

# }

output "application_access" {
    value = [for x in module.container[*]: x]
    description = "The name and the socket fo each applicat"
}

