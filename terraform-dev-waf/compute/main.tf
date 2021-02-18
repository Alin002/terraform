terraform {
    required_version = ">= 0.14"

    backend "s3" {
    
    bucket         = "trf-running-state"
    key            = "terraform.tfstate"
    region         = "eu-west-1"

    # Replace this with your DynamoDB table name!
    #dynamodb_table = "terraform-up-and-running-locks"
    #encrypt        = true
    }
}
    
provider "aws" {
    region = "eu-west-1"
}

/* call the modules */

module "networking" {
    source               = "../modules/networking"

    vpc_cidr              = var.vpc_cidr
    public_subnets_cidr   = var.public_subnets_cidr
#    private_subnets_cidr  = var.private_subnets_cidr
    website_lb_arn        = module.elb.website_lb_arn
#    private_subnet        = module.networking.private_subnet_main
}

module "webserver" {
    source = "../modules/webserver"
    
#     instance_ami           = var.instance_ami
#     compute_public_subnet  = module.networking.public_subnet_main

#     # private_subnet       = module.networking.private_subnet_main
    allow_ssh              = module.webserver.sg_allow_ssh
#    rds_sg                 = module.webserver.rdsdb_sg
#     #secretsmanager_key_name = var.secretsmanager_key_name    
#     key_name       = var.key_name
#     public_key     = var.public_key
    main_vpc       = module.networking.main_vpc_output
}

module "elb" {
    source = "../modules/elb"
    
    lb_name                = var.lb_name
    tg_name                = var.tg_name
    compute_public_subnet  = module.networking.public_subnet_main
    main_vpc               = module.networking.main_vpc_output
#    bastion_instance       = module.webserver.webserver_instances
    allow_ssh              = module.webserver.sg_allow_ssh
    instance_ami           = var.instance_ami
    key_name               = var.key_name
    website                = module.elb.website_lb

#   availability_zones     = ["eu-west-1a", "eu-west-1b"]
}

# module "rds" {
#     source = "../modules/rds"

# #    rds_private_subnet    = module.networking.rds_subnet_group
#     rds_sg                 = module.webserver.rdsdb_sg
# }

module "lambda" {
        source = "../modules/lambda"

        
    }

