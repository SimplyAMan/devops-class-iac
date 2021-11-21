# # Create the security group for ec2 server
# resource "aws_security_group" "exam-sg-ec2" {
#   name = "exam-sg-ec2"
#   description = "Security Group for EC2 Server"
#   vpc_id = aws_vpc.exam-vpc.id

#   ingress {
#     from_port = "80"
#     to_port = "80"
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "exam-sg-ec2"
#   }
# }

# Create an EC2 instance
resource "aws_instance" "exam-ec2" {
  ami           = "ami-0a49b025fffbbdac6"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.exam-ec2-subnet.id
  vpc_security_group_ids = ["${aws_security_group.sg-exam-all.id}"]

  key_name = "aws-key"

  tags = {
    Name = "exam-ec2"
  }
}
