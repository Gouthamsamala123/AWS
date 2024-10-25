# provider "aws" {
#   alias   = "sap"
#   region  = "us-east-1"
#   profile = "sap-account"
# }

# # Create VPC in SAP Account
# resource "aws_vpc" "sap_vpc" {
#   provider   = aws.sap
#   cidr_block = "10.5.0.0/16"
# }

# # Create two subnets for the SAP VPC
# resource "aws_subnet" "sap_subnet1" {
#   provider          = aws.sap
#   vpc_id            = aws_vpc.sap_vpc.id
#   cidr_block        = "10.5.1.0/24"
#   availability_zone = "us-east-1a"
# }

# resource "aws_subnet" "sap_subnet2" {
#   provider          = aws.sap
#   vpc_id            = aws_vpc.sap_vpc.id
#   cidr_block        = "10.5.2.0/24"
#   availability_zone = "us-east-1b"
# }

# # Import Transit Gateway from Network Account (Uniquely named for SAP)
# data "aws_ec2_transit_gateway" "tgw_sap" {
#   provider = aws.sap
#   id       = "tgw-1234567890abcdef0"
# }

# # TGW Attachment for SAP VPC
# resource "aws_ec2_transit_gateway_vpc_attachment" "sap_vpc_attachment" {
#   provider          = aws.sap
#   subnet_ids        = [aws_subnet.sap_subnet1.id, aws_subnet.sap_subnet2.id]
#   transit_gateway_id = data.aws_ec2_transit_gateway.tgw_sap.id
#   vpc_id            = aws_vpc.sap_vpc.id
# }

# # Route Table for SAP VPC
# resource "aws_route_table" "sap_route_table" {
#   provider = aws.sap
#   vpc_id   = aws_vpc.sap_vpc.id
# }

# resource "aws_route_table_association" "sap_subnet1_association" {
#   provider       = aws.sap
#   subnet_id      = aws_subnet.sap_subnet1.id
#   route_table_id = aws_route_table.sap_route_table.id
# }

# resource "aws_route_table_association" "sap_subnet2_association" {
#   provider       = aws.sap
#   subnet_id      = aws_subnet.sap_subnet2.id
#   route_table_id = aws_route_table.sap_route_table.id
# }

# # Create route to the TGW
# resource "aws_route" "sap_route" {
#   provider              = aws.sap
#   route_table_id         = aws_route_table.sap_route_table.id
#   destination_cidr_block = "10.2.0.0/16"  # South America VPC CIDR
#   transit_gateway_id     = data.aws_ec2_transit_gateway.tgw_sap.id
# }

# # Output SAP VPC ID for reference
# output "sap_vpc_id" {
#   value = aws_vpc.sap_vpc.id
# }
