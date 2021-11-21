resource "aws_vpc" "exam-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    "Name" = "exam-vpc"
  }
}

resource "aws_subnet" "exam-ec2-subnet" {
  vpc_id                  = aws_vpc.exam-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "exam-ec2-subnet"
  }
}

resource "aws_subnet" "exam-rds-subnet1" {
  vpc_id                  = aws_vpc.exam-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1b"

  tags = {
    "Name" = "exam-rds-subnet1"
  }
}

resource "aws_subnet" "exam-rds-subnet2" {
  vpc_id                  = aws_vpc.exam-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1c"

  tags = {
    "Name" = "exam-rds-subnet1"
  }
}

resource "aws_db_subnet_group" "exam-rds-subnet-group" {
  name       = "rds subnet group"
  subnet_ids = ["${aws_subnet.exam-rds-subnet1.id}", "${aws_subnet.exam-rds-subnet2.id}"]

  tags = {
    "Name" = "exam-rds-subnet-group"
  }
}

resource "aws_internet_gateway" "exam-igw" {
    vpc_id = aws_vpc.exam-vpc.id

    tags = {
      "Name" = "exam-igw"
    }
}

resource "aws_route_table" "exam-public-crt" {
    vpc_id = aws_vpc.exam-vpc.id
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.exam-igw.id
    }
    
    tags = {
        Name = "exam-public-crt"
    }
}

resource "aws_route_table_association" "exam-crta-public-ec2-subnet" {
  subnet_id      = aws_subnet.exam-ec2-subnet.id
  route_table_id = aws_route_table.exam-public-crt.id
}

resource "aws_route_table_association" "exam-crta-public-rds-subnet-1" {
  subnet_id      = aws_subnet.exam-rds-subnet1.id
  route_table_id = aws_route_table.exam-public-crt.id
}

resource "aws_route_table_association" "exam-crta-public-rds-subnet-2" {
  subnet_id      = aws_subnet.exam-rds-subnet2.id
  route_table_id = aws_route_table.exam-public-crt.id
}

resource "aws_security_group" "sg-exam-all" {
  vpc_id = aws_vpc.exam-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "sg-exam-all"
  }
}