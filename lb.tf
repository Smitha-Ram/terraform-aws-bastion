resource "aws_eip" "bastion" {
  vpc = true
}

resource "aws_lb" "bastion" {
  name = "bastion"
  internal = false
  load_balancer_type = "network"
  subnets = "${var.subnets}"
  enable_deletion_protection = true
  subnet_mapping {
    subnet_id = "${element(var.subnets, 0)}"
    allocation_id = "${aws_eip.bastion.id}"
  }
}

resource "aws_lb_target_group" "bastion" {
  name = "bastion"
  port = "22"
  protocol = "TCP"
  vpc_id = "${var.vpc_id}"
  deregistration_delay = "300"
  health_check {
    interval = "300"
    port = "22"
    protocol = "TCP"
    timeout = "10"
    healthy_threshold = "10"
    unhealthy_threshold= "10"
  }
}

resource "aws_lb_listener" "bastion" {
  load_balancer_arn = "${aws_lb.bastion.arn}"
  port = "22"
  protocol = "TCP"
  default_action {
    target_group_arn = "${aws_lb_target_group.bastion.arn}"
    type = "forward"
  }
}

data "aws_iam_policy_document" "ssh_public_keys" {
  statement {
    sid = "VPCAllow",
    principals {
      type = "AWS",
      identifiers = ["*"]
    },
    effect = "Allow",
    actions = ["s3:GetObject"],
    resources = ["${aws_s3_bucket.ssh_public_keys.arn}/*"],
    condition {
      test = "StringEquals",
      variable = "aws:SourceVpc",
      values = ["${var.vpc_id}"]
    }
  }
}
