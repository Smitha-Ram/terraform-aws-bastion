output "dns_name" {
  value = "${aws_lb.bastion.dns_name}"
}

output "security_group" {
  value = "${aws_security_group.bastion.id}"
}
