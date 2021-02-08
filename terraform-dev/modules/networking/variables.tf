variable "region" {
    description = "AWS Deployment region.."
    default = "eu-west-1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/27"
}

variable "public_subnets_cidr" {
	type = list
	default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
	type = list
	default = ["eu-west-1a", "eu-west-1b"]
}



# variable "public_subnets_cidr" {
#     description = "Public subnet"
#     default = "10.0.0.0/28" 
# }

# variable "private_subnets_cidr" {
#     description = "Private subnet"
#     default = "10.0.0.16/28" 
# }