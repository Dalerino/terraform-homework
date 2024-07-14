data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file("apache-ubuntu.sh")

  tags = {
    Name = "ubuntu"
  }
}

output ubuntu {
    value = aws_instance.ubuntu.public_ip
}

resource "aws_instance" "amazon" {
  ami           = data.aws_ami.amazon.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file("apache-amazon.sh")

  tags = {
    Name = "amazon"
  }
}

output amazon {
    value = aws_instance.amazon.public_ip
}

