provider aws {
    region = var.region
}

# Create VPC named kaizen
resource "aws_vpc" "kaizen" {
  cidr_block = var.vpc_cidr
  enable_dns_support = var.dns_support
  enable_dns_hostnames = var.dns_hostnames

  tags = {
    Name = "kaizen"
  }
}

# Create subnets
resource "aws_subnet" "public1" {
    vpc_id      = aws_vpc.kaizen.id
    cidr_block  = var.subnet_cidrs[0]
    availability_zone = "${var.region}a"
    map_public_ip_on_launch = true

    tags = {
        Name = var.subnet_names[0]
    }
}

resource "aws_subnet" "public2" {
    vpc_id      = aws_vpc.kaizen.id
    cidr_block  = var.subnet_cidrs[1]
    availability_zone = "${var.region}b"
    map_public_ip_on_launch = true

    tags = {
        Name = var.subnet_names[1]
    }
}

resource "aws_subnet" "private1" {
    vpc_id      = aws_vpc.kaizen.id
    cidr_block  = var.subnet_cidrs[2]
    availability_zone = "${var.region}c"
    map_public_ip_on_launch = false

    tags = {
        Name = var.subnet_names[2]
    }
}

resource "aws_subnet" "private2" {
    vpc_id      = aws_vpc.kaizen.id
    cidr_block  = var.subnet_cidrs[3]
    availability_zone = "${var.region}d"
    map_public_ip_on_launch = false

    tags = {
        Name = var.subnet_names[3]
    }
}

# Create and attach Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.kaizen.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.kaizen.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.route_table_names[0]
  }
}

resource "aws_route_table" "my-rt2" {
  vpc_id = aws_vpc.kaizen.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.route_table_names[1]
  }
}
#Associate public and private subnets with rt
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.my-rt2.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.my-rt2.id
}