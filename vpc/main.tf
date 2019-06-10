

# Variables -need to use this module 
variable "AWS_REGION" {
  description = "AWS Region"
}


# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MAIN_VPC"
  }
}

# INTERNET_GW
resource "aws_internet_gateway" "main_igw" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    Name = "MAIN_INTERNET_GW"
  }
}

# ROUTE_TABLE
resource "aws_route_table" "main_public" {
  vpc_id = "${aws_vpc.main.id}"
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main_igw.id}"
  }
  tags = {
    Name = "PUBLIC_ROUTE_TABLE"
  }
}

# SUBNET_PUBLIC 
resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.AWS_REGION}a"
  tags = {
    Name = "PUBLIC_SUBNET"
  }
}

# ROUTE_TABLE_ASSOCIATION
resource "aws_route_table_association" "public_route_table_association" {
  route_table_id = "${aws_route_table.main_public.id}"
  subnet_id = "${aws_subnet.public.id}"
}


# OUTPUTS -this is refferable from module user.
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public.id}"
}












