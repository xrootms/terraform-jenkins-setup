variable "ec2_sg_name" {}
variable "vpc_id" {}
variable "ec2_jenkins_sg_name" {}
variable "sg_ports" {
  default = [22, 80, 443]  # List of ports you want to allow
}

output "sg_ec2_sg_ssh_http_id" {
  value = aws_security_group.ec2_sg_ssh_http_https.id
}

output "sg_ec2_jenkins_port_8080" {
  value = aws_security_group.ec2_jenkins_port_8080.id
}



# SG for 22, 80, 443

resource "aws_security_group" "ec2_sg_ssh_http_https" {
  name        = var.ec2_sg_name
   #description = "Enable the Port 22(SSH) & Port 80(http)"
  vpc_id      = var.vpc_id
    
  ingress {
    description = "Allow remote SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    }

  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

  }

  ingress {
    description = "Allow HTTPS request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

  }

  egress {
    description = "Allow outgoing request"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    
  }
  tags = { Name = "Security Groups to allow SSH(22) and HTTP(80)" }

}




# SG for 8080

resource "aws_security_group" "ec2_jenkins_port_8080" {
  name        = var.ec2_jenkins_sg_name
  description = "Enable the Port 8080 for jenkins"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow 8080 port to access jenkins from anywhere"
  }

  tags = { Name = "Jenkins SG: 8080" }
}


