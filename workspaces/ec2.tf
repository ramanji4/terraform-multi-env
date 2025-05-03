resource "aws_instance" "terraform" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = lookup(var.instance_type, terraform.workspace) 
  vpc_security_group_ids = [aws_security_group.allow_ssh_connection.id]

  tags = {
    Name = "terraform-${terraform.workspace}"
  }
}

resource "aws_security_group" "allow_ssh_connection" {
  name        = "allow_ssh_${terraform.workspace}"
  description = "Allow port number 22 for SSH protocol connection"
  
  egress {      #egress is outgoing traffic
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {      #ingress is incoming traffic to the server
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  #allow from everyone 
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh_${terraform.workspace}"
  }
}