    resource "aws_wafregional_byte_match_set" "bot-user-agent" {
    name = "MatchBotInUserAgent"
    byte_match_tuples {
        text_transformation = "LOWERCASE"
        target_string = "bot"
        positional_constraint = "CONTAINS"
        field_to_match {
        type = "HEADER"
        data = "user-agent"
        }
    }
    }

    resource "aws_wafregional_byte_match_set" "example-uri" {
    name = "MatchExampleRouteInURI"
    byte_match_tuples {
        text_transformation = "NONE"
        target_string = "example_route"
        positional_constraint = "CONTAINS"
        field_to_match {
        type = "URI"
        }
    }
    }


    resource "aws_wafregional_rule" "bot-example-route-control-rule" {
    name        = "MatchBotsAndExampleRoute"
    metric_name = "MatchBotsAndExampleRoute"

    predicate {
        data_id = aws_wafregional_byte_match_set.bot-user-agent.id
        negated = false
        type    = "ByteMatch"
    }
    predicate {
        data_id = aws_wafregional_byte_match_set.example-uri.id
        negated = false
        type    = "ByteMatch"
    }
    }


    resource "aws_wafregional_web_acl" "acl" {
    name = "BlockBotsFromExampleRoute"
    metric_name = "BlockBotsFromExampleRoute"
    default_action {
        type = "ALLOW"
    }
    rule {
        action {
        type = "BLOCK"
        }
        priority = 1
        rule_id = aws_wafregional_rule.bot-example-route-control-rule.id
    }
    }

    resource "aws_wafregional_web_acl_association" "acl-association" {
    resource_arn = var.website_lb_arn
    web_acl_id = aws_wafregional_web_acl.acl.id
    }
    