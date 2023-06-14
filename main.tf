resource "aws_instance" "this" {
  ami           = "ami-07650ecb0de9bd731"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}