variable "region" {
    description = "AWS Deployment region.."
    default = "eu-west-1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/27"
}

variable "public_subnets_cidr" {
	description = "Public subnet"
	type = list
	default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# variable "private_subnets_cidr" {
#     description = "Private subnet"
# 	type = list
#     default = ["10.0.4.0/24", "10.0.5.0/24"] 
# }

# variable "private_subnet"{}
variable "azs" {
	type = list
	default = ["eu-west-1a", "eu-west-1b"]
}

variable "website_lb_arn" {}
#variable "website" {}



