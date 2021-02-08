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

resource "aws_security_group" "rds_sg" {
    name   = "my-rds-sg"
    vpc_id = var.main_vpc

    }

# Ingress Security Port 3306
resource "aws_security_group_rule" "mysql_inbound_access" {
    from_port         = 3306
    protocol          = "tcp"
    security_group_id = aws_security_group.rds_sg.id
    to_port           = 3306
    type              = "ingress"
    cidr_blocks       = ["0.0.0.0/0"]
    }


