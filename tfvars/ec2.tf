resource "aws_security_group" "allow_ssh_connection" {
  name        = "${var.sg_name}_${var.environment}"
  description = var.sg_description
  
  egress {      #egress is outgoing traffic
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {      #ingress is incoming traffic to the server
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = var.protocol
    cidr_blocks      = var.ingress_cidr  #allow from everyone 
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.common_tags,
    var.tags,
    {
      Name = "${var.sg_name}_${var.environment}"
    }
  )
}


resource "aws_instance" "expense" {
  for_each = var.instances   #for_each will give us a special variable called "each" just like as count.index given by count
  ami           = "ami-09c813fb71547fc4f"
  instance_type = each.value 
  vpc_security_group_ids = [aws_security_group.allow_ssh_connection.id]
  tags = merge(
    var.common_tags,
    var.tags,
    {
      Name = each.key
    } 
  )
}




#Here we are using same terraform defintion for different envirionments with different required variables
#After applying the resources creation in any one of the environment, then if we want to create resources in another environment, 
#then we must need to reconfigure the state file of the environment in which we need to create resources by using the below command
# terraform init -reconfigure -backend-config=prod/backend-s3.tf (or) terraform init -reconfigure -backend-config=dev/backend-s3.tf
#while applying resources creation we must need to declare the path of environment specific variables as shown below
#  terraform apply -var-file=dev/dev.tfvars -auto-approve (or) terraform apply -var-file=prod/prod.tfvars -auto-approve

#while destroying the resources also we need to reconfigure the state file by the command which mentioned above and and destroy the 
#resources as same as applying the resources 