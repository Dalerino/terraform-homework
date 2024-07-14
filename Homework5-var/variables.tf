variable region {
    type = string
}

variable vpc_cidr {
    type = string
}

variable internet_gateway_name {
  type = string
}

variable route_table_names {
  type = list(string)
}

variable dns_support {
  type = bool
}

variable dns_hostnames {
  type = bool
}

variable subnet_cidrs {
  type = list(string)
}

variable subnet_names {
  type = list(string)
}

variable ec2_instances {
  type = list(object ({instance_type = string, name = string}))
}

variable port {
  type = list(number)
}