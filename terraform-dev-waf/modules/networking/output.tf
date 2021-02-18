output "main_vpc_output"{
    value = aws_vpc.main_vpc.id
}

output "public_subnet_main"{
    description = "output id of public subnet" 
#    value = element(aws_subnet.compute_public_subnet.*.id,0)
    value = aws_subnet.compute_public_subnet.*.id
}

# output "private_subnet_main"{
#     description = "output id of public subnet"
#     value = aws_subnet.private_subnet.*.id
# #    value = aws_subnet.private_subnet.id
# }


