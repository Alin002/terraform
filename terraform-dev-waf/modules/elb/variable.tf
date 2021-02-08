# #variable "instance_count"{}

variable "lb_name" {}
variable "tg_name"{}   
variable "compute_public_subnet" { }
variable "website" {}

# variable "bastion_instance" {
#     type = list
# }
variable "main_vpc" {}

# variable availability_zones {}
variable allow_ssh {}
variable "instance_ami" {}
variable "instance_type"{
    default = "t2.micro"
}
variable "key_name" {}

