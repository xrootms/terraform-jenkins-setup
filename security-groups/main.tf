variable "ec2_sg_name" {}
variable "vpc_id" {}
variable "ec2_jenkins_sg_name" {}
variable "sg_ports" { default = [22, 80, 443] }

output "sg_ec2_sg_ssh_http_id" {
  value = aws_security_group.ec2_sg_ssh_http_https.id
}

output "sg_ec2_jenkins_port_8080" {
  value = aws_security_group.ec2_jenkins_port_8080.id
}


#SG for ports: 22, 80, 443

resource "aws_security_group" "ec2_sg_ssh_http_https" {
  name        = var.ec2_sg_name
  vpc_id      = var.vpc_id
  description = "Enable the Port 22(SSH), Port 80(http) & port 443(https)"

  #Allow all outbound traffic 
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outgoing request to anywhere"
  }
  tags = { Name = "Security Group: SSH(22), HTTP(80) and HTTPs(443)" }
}

#Ingress rules using count

resource "aws_security_group_rule" "sg_ingress" {
  count             = length(var.sg_ports)
  type              = "ingress"
  from_port         = var.sg_ports[count.index]
  to_port           = var.sg_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg_ssh_http_https.id
  description       = "Allow port ${var.sg_ports[count.index]} from anywhere"
}


#SG for jenkins port 8080

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


