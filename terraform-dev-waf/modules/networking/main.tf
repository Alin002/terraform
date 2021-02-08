/*==== The VPC ======*/

provider "aws" {
    region  = var.region
}

resource "aws_vpc" "main_vpc" {
    cidr_block  = var.vpc_cidr
    tags = {
    Name        = "vpc-bytrf"
    }
}


/*==== Subnets ======*/
/* Public subnet */
resource "aws_subnet" "compute_public_subnet" {
    count     = length(var.public_subnets_cidr)
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = element(var.public_subnets_cidr,count.index)
    map_public_ip_on_launch = "true"
    availability_zone       = element(var.azs,count.index)
    
    tags = {
    Name        = "public-subnet-bytrf-${count.index+1}"
    }
}

/* Private subnet */
resource "aws_subnet" "private_subnet" {
    count     = length(var.private_subnets_cidr)
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = element(var.private_subnets_cidr,count.index)
    map_public_ip_on_launch = "false"
    availability_zone       = element(var.azs,count.index)

    tags = {
    Name        = "private-subnet-bytrf-${count.index+1}"
    }
}

resource "aws_db_subnet_group" "rds_private_subnet" {
    name = "rds-private-subnet-group"
    subnet_ids = var.private_subnet[*]
}


resource "aws_internet_gateway" "internet_gw" {
    vpc_id = aws_vpc.main_vpc.id

    tags = {
    Name = "internet-gw"
    }
}

/* Routing table for public subnet */
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gw.id
    }

    tags = {
    Name        = "public_rt"
    }
}

/* Route table associations with public subnet*/
resource "aws_route_table_association" "public_rta" {
    count = length(var.public_subnets_cidr)
    subnet_id = element(aws_subnet.compute_public_subnet.*.id,count.index)
#   subnet_id      = aws_subnet.compute_public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_eip" "nat" {
    vpc = true
}

# resource "aws_nat_gateway" "nat_gw" {
#     allocation_id = aws_eip.nat.id
#     subnet_id     = aws_subnet.compute_public_subnet.id
#     depends_on    = [aws_internet_gateway.internet_gw]
# }




# /* Routing table for private subnet */
# resource "aws_route_table" "private_rt" {
#     vpc_id = aws_vpc.main_vpc.id
#     route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat_gw.id
#     }

#     tags = {
#     Name        = "private-rt"
#     }
# }

# resource "aws_route_table_association" "private_rta" {
#     subnet_id      = aws_subnet.private_subnet.id
#     route_table_id = aws_route_table.private_rt.id
# }
