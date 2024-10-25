# provider "aws" {
#   alias   = "prod"
#   region  = "us-east-1"
#   profile = "prod-account"
# }

# # Create VPC in Prod Account
# resource "aws_vpc" "prod_vpc" {
#   provider   = aws.prod
#   cidr_block = "10.1.0.0/16"
# }

# # Create two subnets for the Prod VPC
# resource "aws_subnet" "prod_subnet1" {
#   provider          = aws.prod
#   vpc_id            = aws_vpc.prod_vpc.id
#   cidr_block        = "10.1.1.0/24"
#   availability_zone = "us-east-1a"
# }

# resource "aws_subnet" "prod_subnet2" {
#   provider          = aws.prod
#   vpc_id            = aws_vpc.prod_vpc.id
#   cidr_block        = "10.1.2.0/24"
#   availability_zone = "us-east-1b"
# }

# # Import the Transit Gateway from Network Account
# data "aws_ec2_transit_gateway" "tgw" {
#   provider = aws.prod
#   id       = "tgw-0123456789abcdef0"
# }

# # TGW Attachment for Prod VPC
# resource "aws_ec2_transit_gateway_vpc_attachment" "prod_vpc_attachment" {
#   provider          = aws.prod
#   subnet_ids        = [aws_subnet.prod_subnet1.id, aws_subnet.prod_subnet2.id]
#   transit_gateway_id = data.aws_ec2_transit_gateway.tgw.id
#   vpc_id            = aws_vpc.prod_vpc.id
# }

# # Create route table and associate it with subnets
# resource "aws_route_table" "prod_route_table" {
#   provider = aws.prod
#   vpc_id   = aws_vpc.prod_vpc.id
# }

# resource "aws_route_table_association" "prod_subnet1_association" {
#   provider       = aws.prod
#   subnet_id      = aws_subnet.prod_subnet1.id
#   route_table_id = aws_route_table.prod_route_table.id
# }

# resource "aws_route_table_association" "prod_subnet2_association" {
#   provider       = aws.prod
#   subnet_id      = aws_subnet.prod_subnet2.id
#   route_table_id = aws_route_table.prod_route_table.id
# }

# # Create a route to the TGW
# resource "aws_route" "prod_route" {
#   provider              = aws.prod
#   route_table_id         = aws_route_table.prod_route_table.id
#   destination_cidr_block = "10.2.0.0/16"  # South America VPC CIDR
#   transit_gateway_id     = data.aws_ec2_transit_gateway.tgw.id
# }

# # Output VPC ID for future references
# output "prod_vpc_id" {
#   value = aws_vpc.prod_vpc.id
# }

# output "prod_subnet1_id" {
#   value = aws_subnet.prod_subnet1.id
# }

# output "prod_subnet2_id" {
#   value = aws_subnet.prod_subnet2.id
# }

# output "prod_route_table_id" {
#   value = aws_route_table.prod_route_table.id
# }

# output "prod_route_id" {
#   value = aws_route.prod_route.id
# }

# output "prod_tgw_id" {
#   value = data.aws_ec2_transit_gateway.tgw.id
# }
