data "aws_ami" "coreos" {
  most_recent = true
  owners = ["595879546273"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "name"
    values = ["CoreOS-stable-*"]
  }
}

data "ignition_user" "tunnel" {
  name = "tunnel"
  no_create_home = true
  shell = "/bin/false"
}

data "ingition_file" "sshd_config" {
  path = "/etc/ssh/sshd_config"
}

data "ignition_config" "bastion" {
  users = [
    "${data.ignition_user.tunnel.id}",
  ]
  files = [
    "${data.ignition_file.sshd_config.id}",
  ]
}

resource "aws_launch_configuration" "bastion" {
  image_id = "${data.aws_ami.coreos.image_id}"
  instance_type = "${var.instance_type}"
  user_data = "${data.ignition_config.bastion.rendered}"
  enable_monitoring = true
  security_groups = [
    "${aws_security_group.bastion.id}"
  ]
  root_block_device {
    volume_size = "8gb"
  }
  iam_instance_profile = "${var.iam_instance_profile}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name = "lrvick" // temporary hardcoded key hack so I can develop s3 key fetch script
  lifecycle {
    create_before_destroy = true
  }
}
