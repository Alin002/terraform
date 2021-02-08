/*==== The Ec2 Instances ======*/

# resource "aws_instance" "bastion_instance" {

#     count         = var.instance_count
#     ami           = var.instance_ami
#     instance_type = var.instance_type

#     subnet_id     = element(var.compute_public_subnet, count.index)
#     key_name      = var.key_name
#     security_groups = [var.allow_ssh]

#     connection {
        
#         host = self.public_ip
#         type = "ssh"
#         user = "ec2-user"
#         private_key = file("my_keypair.pem")
#         timeout     = "1m"
#     }
    
#     provisioner "file" {
#         source = "apachescript.sh"
#         destination = "/tmp/apachescript.sh"
#     }
#     provisioner "file" {
#     source      = "index.html"
#     destination = "/tmp/index.html"
#     }
#     provisioner "remote-exec" {
#     inline = [
#         "sudo chmod +x /tmp/apachescript.sh",
#         "sudo /tmp/apachescript.sh",
#         "sudo chmod -R 755 /var/www/html",
#         "sudo mv /tmp/index.html /var/www/html/index.html"
#     ]
#     }
    
#     tags = {
#         Name = "Terraform-${count.index+1}"
#     }
    
# }

# resource "aws_instance" "private-instance" {
#     ami           = var.instance_ami
#     instance_type = var.instance_type
#     subnet_id     = var.private_subnet
#     key_name      = var.key_name


#     tags = {
#     Name = "private-instance"
#     }
# }




