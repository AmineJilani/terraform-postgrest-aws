resource "aws_instance" "postgrest" {
  ami           = "ami-02e73d7872fcc1b49"
  instance_type = "t4g.micro"
  key_name      = "postgrest-key"

  subnet_id              = "subnet-0c59c9d3cc83f1ec9"
  vpc_security_group_ids = [aws_security_group.ec2.id]

  #associate_public_ip_address = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "postgrest-ec2"
  }

}