resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    Name = "vpc-virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-virginia-targeting-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    Name = "private-subnet-virginia-targeting-${local.sufix}"
  }
  depends_on = [aws_subnet.public_subnet]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id
  tags = {
    Name = "igw vpc virgina-${local.sufix}"
  }
}

resource "aws_route_table" "route_table_public_subnet" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = var.cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Routing Table Public Subnet-${local.sufix}"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table_public_subnet.id
}

resource "aws_security_group" "EC2_instance" {
  name        = "EC2 Instance"
  description = "Allow SSH inbound traffic and all outbound traffic-${local.sufix}"
  vpc_id      = aws_vpc.vpc_virginia.id
  tags = {
    Name = "EC2 Rules"
  }
}

resource "aws_vpc_security_group_ingress_rule" "SSH_instance" {
  security_group_id = aws_security_group.EC2_instance.id
  cidr_ipv4         = var.cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "HTTP_instance" {
  security_group_id = aws_security_group.EC2_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.EC2_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
