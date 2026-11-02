# Instance EC2 hébergeant Docker et le conteneur PostgREST.


resource "aws_instance" "postgrest" {
  ami           = "ami-02e73d7872fcc1b49"
  instance_type = "t4g.micro"
  key_name      = "postgrest-key" # Paire de clés SSH existante dans la région

  subnet_id              = data.aws_subnet.ec2.id #Subnet par défaut
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