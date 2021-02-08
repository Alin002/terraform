resource "aws_launch_configuration" "web" {
    name_prefix = "web-"

    image_id      = var.instance_ami
    instance_type = var.instance_type
    key_name      = var.key_name

    security_groups = [var.allow_ssh]
    associate_public_ip_address = true

    user_data = <<USER_DATA
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras install epel
    sudo yum install stress -y
    sudo yum install mysql
    USER_DATA

    lifecycle {
        create_before_destroy = true
    }
    }

resource "aws_autoscaling_group" "web" {
    name = "web-asg2"

    min_size             = 2
    desired_capacity     = 2
    max_size             = 4
    
    health_check_type    = "ELB"
    target_group_arns    = [aws_alb_target_group.group.arn]
#    load_balancers = [aws_alb.website.id]

    launch_configuration = aws_launch_configuration.web.name

    enabled_metrics = [
        "GroupMinSize",
        "GroupMaxSize",
        "GroupDesiredCapacity",
        "GroupInServiceInstances",
        "GroupTotalInstances"
    ]

    metrics_granularity = "1Minute"

    vpc_zone_identifier  = var.compute_public_subnet[*]

    # Required to redeploy without an outage.
    lifecycle {
        create_before_destroy = true
    }

    tag {
        key                 = "Name"
        value               = "web"
        propagate_at_launch = true
    }

    }


    resource "aws_autoscaling_policy" "web_policy_up" {
    name = "web_policy_up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = aws_autoscaling_group.web.name
    }

    resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
    alarm_name = "web_cpu_alarm_up"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "75"

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.web.name
    }

    alarm_description = "This metric monitor EC2 instance CPU utilization"
    alarm_actions = [ aws_autoscaling_policy.web_policy_up.arn ]
    }

    resource "aws_autoscaling_policy" "web_policy_down" {
    name = "web_policy_down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = aws_autoscaling_group.web.name
    }

    resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
    alarm_name = "web_cpu_alarm_down"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "10"

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.web.name
    }

    alarm_description = "This metric monitor EC2 instance CPU utilization"
    alarm_actions = [ aws_autoscaling_policy.web_policy_down.arn ]
    }

    