provider aws {
    region = "us-west-2"
}

resource "aws_key_pair" "deployer" {
key_name   = "bastion"
public_key = file("~/.ssh/id_rsa.pub")
}

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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  availability_zone = element(["us-west-2a", "us-west-2b", "us-west-2c"], count.index)
  count = 3
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file("apache.sh")
  associate_public_ip_address = true

  tags = {
    Name = "web-${count.index + 1}"
  }
}

output ec2 {
  value = aws_instance.web[0].public_ip
}