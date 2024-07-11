provider aws {
    region = var.region
}

resource "aws_key_pair" "bastion" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  count = var.count_ec2
  availability_zone = var.availability_zone
  key_name = aws_key_pair.bastion.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "HW-4"
  }
}

variable ami_id {
    description = "Provide AMI id"
    type = string
    default = ""
}

variable instance_type {
    description = "Provide instance type"
    type = string
    default = ""
}

variable count_ec2 {
    description = "Provide count ec2"
    type = number
    default = 1
}

variable region {
    description = "Provide region"
    type = string
    default = ""
}

variable ports {
    description = "Provide ports to allow access to ec2 instance"
    type = list
}

variable availability_zone {
    description = "Provide availability zone"
    type = string
    default = ""
}

variable key_name {
    description = "Provide key name"
    type = string
    default = ""
}

#ami-0649bea3443ede307