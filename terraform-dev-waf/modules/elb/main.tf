resource "aws_alb" "website" {

    load_balancer_type = "application"
    name               = var.lb_name
    subnets            = var.compute_public_subnet[*]
    security_groups    = [var.allow_ssh]
    internal           = false
    enable_deletion_protection = false
#    vpc_id             = var.main_vpc

    tags = {
        Name = "website-terraform-alb"
    }

}
resource "aws_alb_target_group" "group" {
    name     = var.tg_name
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.main_vpc

    stickiness {
    type = "lb_cookie"
    }
    
    health_check {
    path = "/index.html"
    port = 80
    }
}

resource "aws_alb_listener" "listener_http" {
    load_balancer_arn = aws_alb.website.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
    target_group_arn = aws_alb_target_group.group.arn
    type             = "forward"
    }

}





