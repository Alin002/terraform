output "website_lb" {
    description = "ALB created for http 80"
    value = aws_alb.website.id
}