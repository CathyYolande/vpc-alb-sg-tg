# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_instance" "web" {
  ami                                  = "ami-04681163a08179f28"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1d"
  instance_type                        = "t2.micro"
  key_name                             = "resume"
  subnet_id                            = "subnet-05e4247653197a6c2"
  vpc_security_group_ids      = ["sg-01fe1c57f72403950"]
  tags = {
    Name = "import-server"
  }
  
  
}
