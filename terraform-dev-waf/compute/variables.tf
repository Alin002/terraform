variable "region" {
    description = "AWS Deployment region.."
    default = "eu-west-1"
}

variable "vpc_cidr" { }
variable "tenancy_dev" { }
variable "instance_ami" { }
variable "key_name" {
    type = string
}
# variable "public_key" {
#     type = string
# }

variable "instance_type"{
    default = "t2.micro"
}

#variable "public_subnet_main" {}

variable "public_subnets_cidr" {
	type = list
	default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
    description = "Private subnet"
	type = list
    default = ["10.0.4.0/24", "10.0.5.0/24"] 
}
variable "lb_name" {
    description = "the elb name"
}
variable "tg_name"{}


# variable "public_subnets_cidr" {
#     description = "Public subnet"
#     default = "10.0.0.0/28" 
# }

# variable "private_subnets_cidr" {
#     description = "Private subnet"
#     default = "10.0.0.16/28" 
# }
