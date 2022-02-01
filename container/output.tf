#Output the IP Address of the Container
# output "container_name" {
#   value       = docker_container.nodered_container.name
#   description = "The name"

# }


# output "container_ip_port" {

#   value = [for i in docker_container.nodered_container[*]: join(":",[i.ip_address],i.ports[*]["internal"])]

# }


output "application_access" {
    value = {for x in docker_container.app_container[*]: x.name => join(":",[x.ip_address],x.ports[*]["external"])}
}