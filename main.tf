terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "My-VPC"
  }
}
resource "aws_subnet" "pubsub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "PUBSUB"
  }
}
resource "aws_subnet" "prisub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "PRISUB"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "IGW"
  }
}
resource "aws_route_table" "pubroute" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "PubRoute"
  }
}
resource "aws_main_route_table_association" "pubassoct" {
  vpc_id         = aws_vpc.myvpc.id
  route_table_id = aws_route_table.pubroute.id
}
resource "aws_eip" "myeip" {
  domain   = "vpc"
}
resource "aws_nat_gateway" "mynat" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.pubsub.id

  tags = {
    Name = "MYNAT"
  }
}
resource "aws_route_table" "priroute" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id =  aws_nat_gateway.mynat.id
  }
  tags = {
    Name = "PriRoute"
  }
}
resource "aws_main_route_table_association" "priassoct" {
  vpc_id         = aws_vpc.myvpc.id
  route_table_id = aws_route_table.priroute.id
}




