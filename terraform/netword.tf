resource "aws_vpc" "lesson12-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    "Name" = "lesson12-vpc"
  }
}

resource "aws_subnet" "lesson12-ec2-subnet" {
  vpc_id                  = aws_vpc.lesson12-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "lesson12-ec2-subnet"
  }
}

resource "aws_subnet" "lesson12-rds-subnet1" {
  vpc_id                  = aws_vpc.lesson12-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1b"

  tags = {
    "Name" = "lesson12-rds-subnet1"
  }
}

resource "aws_subnet" "lesson12-rds-subnet2" {
  vpc_id                  = aws_vpc.lesson12-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1c"

  tags = {
    "Name" = "lesson12-rds-subnet1"
  }
}

resource "aws_db_subnet_group" "lesson12-rds-subnet-group" {
  name       = "rds subnet group"
  subnet_ids = ["${aws_subnet.lesson12-rds-subnet1.id}", "${aws_subnet.lesson12-rds-subnet2.id}"]

  tags = {
    "Name" = "lesson12-rds-subnet-group"
  }
}

resource "aws_internet_gateway" "lesson12-igw" {
    vpc_id = aws_vpc.lesson12-vpc.id

    tags = {
      "Name" = "lesson12-igw"
    }
}

resource "aws_route_table" "lesson12-public-crt" {
    vpc_id = aws_vpc.lesson12-vpc.id
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.lesson12-igw.id
    }
    
    tags = {
        Name = "lesson12-public-crt"
    }
}

resource "aws_route_table_association" "lesson12-crta-public-ec2-subnet" {
  subnet_id      = aws_subnet.lesson12-ec2-subnet.id
  route_table_id = aws_route_table.lesson12-public-crt.id
}

resource "aws_route_table_association" "lesson12-crta-public-rds-subnet-1" {
  subnet_id      = aws_subnet.lesson12-rds-subnet1.id
  route_table_id = aws_route_table.lesson12-public-crt.id
}

resource "aws_route_table_association" "lesson12-crta-public-rds-subnet-2" {
  subnet_id      = aws_subnet.lesson12-rds-subnet2.id
  route_table_id = aws_route_table.lesson12-public-crt.id
}

resource "aws_security_group" "sg-lesson12-all" {
  vpc_id = aws_vpc.lesson12-vpc.id

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = -1
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  # ingress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = -1
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  tags = {
    "Name" = "sg-lesson12-all"
  }
}