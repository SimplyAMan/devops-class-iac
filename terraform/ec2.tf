# Create an EC2 instance
resource "aws_instance" "lesson12-ec2" {
  ami           = "ami-0a49b025fffbbdac6"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.lesson12-ec2-subnet.id
  vpc_security_group_ids = ["${aws_security_group.sg-lesson12-all.id}"]

  key_name = "aws-key"

  tags = {
    Name = "lesson12-ec2"
  }
}
