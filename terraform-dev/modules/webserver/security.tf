/*==== VPC's Default Security Group ======*/
resource "aws_security_group" "allow_ssh" {
    vpc_id      = var.main_vpc
    name        = "allow-ssh"
    description = "SG allow ssh and all outbound traffic"

    ingress {
        from_port = "22"
        to_port   = "80"
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = "0"
        to_port   = "0"
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "allow ssh"
    }
}


