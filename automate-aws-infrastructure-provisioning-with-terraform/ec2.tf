resource "aws_instance" "demo" {
  ami           = "ami-066784287e358dad1"
  instance_type = "t3.micro"
}
