output "sg_allow_ssh" {
    description = "SG used for vpc and instances"
    value = aws_security_group.allow_ssh.id
}

output "rdsdb_sg" {
    description = "SG used for rds connection"
    value = aws_security_group.rds_sg.id
}

# output "webserver_instances" {
#     description = "Instances id created in module webserver"
# #    value = element(aws_instance.bastion_instance.*.id,0)
#     value = aws_instance.bastion_instance.*.id
# }

# output "my_ssh_keypair" {
#     description = "Provided aws public key pair"
#     value       = aws_key_pair.test_keypair.id
# }

