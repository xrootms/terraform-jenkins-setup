variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "ap_availability_zone" {}
variable "cidr_private_subnet" {}

#setup vpc

resource "aws_vpc" "dev_proj_1_vpc" {
    cidr_block = var.vpc_cidr
    tags = { Name = var.vpc_name }
}

# setup public subnet

resource "aws_subnet" "dev_proj_public_subnets" {
    count = length(var.cidr_public_subnet)
    vpc_id = aws_vpc.dev_proj_1_vpc.id
    cidr_block = element(var.cidr_public_subnet, count.index)
    availability_zone = element(var.ap_availability_zone, count.index)
    tags = { Name = "dev_proj_1_public_subnet-${count.index + 1}" }
  
}

# setup private subnet

resource "aws_subnet" "dev_proj_1_private_subnets" {
    count = length(var.cidr_private_subnet)
    vpc_id = aws_vpc.dev_proj_1_vpc.id 
    cidr_block = element(var.cidr_private_subnet, count.index)
    availability_zone = element(var.ap_availability_zone, count.index)
    tags = { Name = "dev_proj_1_private_subnet-${count.index + 1}" }
}

# Setup Internet Gateway

resource "aws_internet_gateway" "dev_proj_1_ig" {
    vpc_id = aws_vpc.dev_proj_1_vpc.id
    tags = { Name = "dev_proj_1_ig" }

}