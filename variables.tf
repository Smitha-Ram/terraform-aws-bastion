variable "instance_type" { default = "t2.nano" }
variable "authorized_keys_directory" {}
variable "authorized_key_names" { type = "list" }
variable "associate_public_ip_address" { default = true }
variable "iam_instance_profile" { default = "" }
variable "allowed_cidrs" { type="list" }
variable "vpc_id" {}
variable "subnets" { type="list" }
variable "ssh_port" { default = "22" }
variable "key_name" { default = "" }
