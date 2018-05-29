resource "aws_security_group" "bastion" {
  name = "bastion"
  vpc_id = "${var.vpc_id}"
  tags {
    Name = "bastion"
  }
}

resource "aws_security_group_rule" "bastion_ssh_ingress" {
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = "${var.allowed_cidr}"
  security_group_id = "${aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "bastion_all_egress" {
  type = "egress"
  from_port = "0"
  to_port = "65535"
  protocol  = "all"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  security_group_id = "${aws_security_group.bastion.id}"
}
