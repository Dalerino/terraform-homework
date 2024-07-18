provider aws {
    region = var.region
}

# Create VPC named kaizen
resource "aws_vpc" "kaizen" {
  cidr_block = var.vpc_cidr[0].cidr_block
  enable_dns_support = var.vpc_cidr[0].dns_support
  enable_dns_hostnames = var.vpc_cidr[0].dns_hostnames

  tags = {
    Name = "kaizen"
  }
}

# Create subnets
resource "aws_subnet" "public1" {
    vpc_id      = aws_vpc.kaizen.id
    cidr_block  = var.subnet[0].cidr
    availability_zone = "${var.region}a"
    map_public_ip_on_launch = var.ip_on_launch

    tags = {
        Name = var.subnet[0].subnet_name
    }
}

resource "aws_subnet" "public2" {
    vpc_id      = aws_vpc.kaizen.id
    cidr_block  = var.subnet[1].cidr
    availability_zone = "${var.region}b"
    map_public_ip_on_launch = var.ip_on_launch

    tags = {
        Name = var.subnet[1].subnet_name
    }
}

resource "aws_subnet" "private1" {
    vpc_id      = aws_vpc.kaizen.id
    cidr_block  = var.subnet[2].cidr
    availability_zone = "${var.region}c"
    map_public_ip_on_launch = false

    tags = {
        Name = var.subnet[2].subnet_name
    }
}

resource "aws_subnet" "private2" {
    vpc_id      = aws_vpc.kaizen.id
    cidr_block  = var.subnet[3].cidr
    availability_zone = "${var.region}d"
    map_public_ip_on_launch = false

    tags = {
        Name = var.subnet[3].subnet_name
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
    Name = "public-rt"
  }
}

resource "aws_route_table" "my-rt2" {
  vpc_id = aws_vpc.kaizen.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "private-rt"
  }
}
#Associate public and private subnets with rt
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.my-rt2.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.my-rt2.id
}