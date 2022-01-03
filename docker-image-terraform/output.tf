#Output the IP Address of the Container
output "container_name" {
  value       = docker_container.nodered_container[*].name
  description = "The name"

}


output "container_ip_port" {

  value = [for i in docker_container.nodered_container[*]: join(":",[i.ip_address],i.ports[*]["internal"])]

}
