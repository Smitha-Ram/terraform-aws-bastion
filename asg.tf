resource "aws_autoscaling_group" "bastion" {
  name = "bastion"
  vpc_zone_identifier = "${var.subnets}"
  desired_capacity = "1"
  min_size = "1"
  max_size = "1"
  health_check_grace_period = "60"
  health_check_type = "EC2"
  force_delete = false
  wait_for_capacity_timeout = 0
  launch_configuration = "${aws_launch_configuration.bastion.name}"
  target_group_arns = ["${aws_lb_target_group.bastion.arn}"]
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
  tags = [
    {
      "key" = "name"
      "value" = "bastion"
      "propagate_at_launch" = "true"
    },
    {
      "key" = "EIP"
      "value" = "${aws_eip.bastion.public_ip}"
      "propagate_at_launch" = "true"
    }
  ]
  lifecycle {
    create_before_destroy = true
  }
}
