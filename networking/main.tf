variable "vpc_cidr" {}
variable "vpc_name" {}

#setup vpc

resource "aws_vpc" "dev_proj_1_vpc" {
    cidr_block = var.vpc_cidr
    tags = { Name = var.vpc_name }
}
