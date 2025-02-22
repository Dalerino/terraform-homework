variable "region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "ip_on_launch" {
  type = bool
}

variable "port" {
  type    = list(number)
  default = [22, 80, 443]
}

variable "subnet" {
  type = list(object({
    cidr        = string
    subnet_name = string
  }))
}


# variable "region" {
#   type = string
# }

# variable "vpc_cidr" {
#   type = string
# }

# variable "ip_on_launch" {
#   type = bool
# }

# variable port {
#     type = list(number)
#     default = [22, 80, 443]
# }

# variable "subnet" {
#   type = list(object({
#     cidr        = string
#     subnet_name = string
#   }))
# }

# variable "internet_gateway_name" {
#   type = string
# }

# variable "route_table_names" {
#   type = list(any)
# }

# #variable ec2_instances {
# #type = list(object( {
# #instance_type = string
# #name = string
# #}))
# #}

# variable "dns_support" {
#   type    = bool
#   default = true
# }

# variable "dns_hostnames" {
#   type    = bool
#   default = true
# }