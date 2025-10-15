variable "lb_target_group_name" {}
variable "lb_target_group_port" {}
variable "lb_target_group_protocol" {}
variable "vpc_id" {}
variable "ec2_instance_id" {}

output "ec2_instance_id" {
    value = aws_lb_target_group.dev_proj_1_lb_target_group.arn
}



resource "aws_lb_target_group" "dev_proj_1_lb_target_group" {
    name     = var.lb_target_group_name
    port     = var.lb_target_group_port        # port on which targets receive traffic from the lb.
    protocol = var.lb_target_group_protocol    # protocol used for routing traffic to the targets (e.g., HTTP, HTTPS, TCP).
    vpc_id   = var.vpc_id
    health_check {
        path = "/login"
        port = 8080                            # use for health-checks. uses the same port as the tg
        healthy_threshold = 6                  # no. of consecutive successful health-checks, required before a target is considered healthy.
        unhealthy_threshold = 2                # no. of consecutive failed health-checks, required before a target is considered unhealthy.
        timeout = 2                            # amount of time, during which no-response means a failed healt-check. 
        interval = 5                           # The time, between health-checks.
        matcher = "200"
    }
    
}

resource "aws_lb_target_group_attachment" "dev_proj_1_lb_target_group_attachment" {
    target_group_arn = aws_lb_target_group.dev_proj_1_lb_target_group.arn
    target_id        = var.ec2_instance_id
    port             = 8080

}