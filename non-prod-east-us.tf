# provider "aws" {
#   alias   = "nonprod"
#   region  = "us-east-1"
#   profile = "non-prod-account"
# }

# # Create VPC in Non-Prod Account
# resource "aws_vpc" "nonprod_vpc" {
#   provider   = aws.nonprod
#   cidr_block = "10.3.0.0/16"
# }

# # Create two subnets for the Non-Prod VPC
# resource "aws_subnet" "nonprod_subnet1" {
#   provider          = aws.nonprod
#   vpc_id            = aws_vpc.nonprod_vpc.id
#   cidr_block        = "10.3.1.0/24"
#   availability_zone = "us-east-1a"
# }

# resource "aws_subnet" "nonprod_subnet2" {
#   provider          = aws.nonprod
#   vpc_id            = aws_vpc.nonprod_vpc.id
#   cidr_block        = "10.3.2.0/24"
#   availability_zone = "us-east-1b"
# }

# # Import Transit Gateway from Network Account (Unique Name)
# data "aws_ec2_transit_gateway" "tgw_nonprod" {
#   provider = aws.nonprod
#   id       = "tgw-1234567890abcdef0"  # Replace with your actual TGW ID
# }

# # TGW Attachment for Non-Prod VPC
# resource "aws_ec2_transit_gateway_vpc_attachment" "nonprod_vpc_attachment" {
#   provider          = aws.nonprod
#   subnet_ids        = [aws_subnet.nonprod_subnet1.id, aws_subnet.nonprod_subnet2.id]
#   transit_gateway_id = data.aws_ec2_transit_gateway.tgw_nonprod.id
#   vpc_id            = aws_vpc.nonprod_vpc.id
# }

# # Route Table for Non-Prod VPC
# resource "aws_route_table" "nonprod_route_table" {
#   provider = aws.nonprod
#   vpc_id   = aws_vpc.nonprod_vpc.id
# }

# resource "aws_route_table_association" "nonprod_subnet1_association" {
#   provider       = aws.nonprod
#   subnet_id      = aws_subnet.nonprod_subnet1.id
#   route_table_id = aws_route_table.nonprod_route_table.id
# }

# resource "aws_route_table_association" "nonprod_subnet2_association" {
#   provider       = aws.nonprod
#   subnet_id      = aws_subnet.nonprod_subnet2.id
#   route_table_id = aws_route_table.nonprod_route_table.id
# }

# # Create route to the TGW
# resource "aws_route" "nonprod_route" {
#   provider              = aws.nonprod
#   route_table_id         = aws_route_table.nonprod_route_table.id
#   destination_cidr_block = "10.2.0.0/16"  # Example CIDR for South America
#   transit_gateway_id     = data.aws_ec2_transit_gateway.tgw_nonprod.id
# }

# # Output Non-Prod VPC ID for reference
# output "nonprod_vpc_id" {
#   value = aws_vpc.nonprod_vpc.id
# }
