# EC2 Instance for WordPress
resource "aws_instance" "group_3" {
  ami = "ami-00db8dadb36c9815e"
  # ami = "ami-08be1e3e6c338b037"
  # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet1.id
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = ["${aws_security_group.group_3.id}"]
  user_data              = file("wordpress.sh")
  tags = {
    Name = "group-3"
  }
}