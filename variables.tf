variable "instance_type" { default = "t2.nano" }
variable "authorized_keys_directory" {}
variable "authorized_key_names" {}
variable "iam_instance_profile" {}
variable "allowed_cidrs" { type="list" }
variable "vpc_id" {}
variable "subnets" {}
variable "ssh_port" {}
variable "key_name" {}
