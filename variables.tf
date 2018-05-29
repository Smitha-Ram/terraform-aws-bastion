variable "instance_type" { default = "t2.nano" }
variable "authorized_keys_directory" {}
variable "authorized_key_names" {}
variable "allowed_cidrs" { type="list" }
variable "vpc_id" {}
variable "public_subnets" {}
