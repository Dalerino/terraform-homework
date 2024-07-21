variable region {
    type = string
    description = "Provide region"
}

variable instance_type {
    type = string
    description = "Provide instance type"
}

variable port {
    type = list(number)
    default = [22, 80, 443]
}