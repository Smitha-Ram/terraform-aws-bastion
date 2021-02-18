variable "name" {
  default = "bastion"
}

variable "instance_type" {
  default = "t2.nano"
}

variable "authorized_keys_directory" {
}

variable "authorized_key_names" {
  type = list(string)
}

variable "allowed_users" {
  type    = list(string)
  default = ["tunnel"]
}

variable "associate_public_ip_address" {
  default = true
}

variable "iam_instance_profile" {
  default = ""
}

variable "allowed_cidrs" {
  type = list(string)
}

variable "create_egress_rule" {
  description = "Should this module create a rule to allow the bastion to connect to everywhere?"
  default     = true
  type        = bool
}

variable "vpc_id" {
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "ssh_port" {
  default = "22"
}

variable "key_name" {
  default = ""
}
