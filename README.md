# Terraform AWS Bastion #

<http://github.com/BitGo/terraform-aws-bastion>

## About ##

Deploy a minimal, auto-healing, and immutable SSH Bastion host on AWS.

## Features ##

  * Automatically re-deploy via ASG and health checks
  * Automatic updates via CoreOS
  * Static IP via Network Load Balancer
  * Public keys fetched on the fly from s3 bucket

## Usage  ##

### Variables

  * ```name``` - name of the bastion; suggest 'bastion-<unique_identifier>'
  * ```instance_type``` - instance type of bastion
  * ```authorized_keys_directory``` - folder of keys to allow for ssh
  * ```authorized_key_names``` - names of public keys to allow for ssh
  * ```allowed_cidrs``` - CIDRs that are allowed to reach instance via SSH
  * ```allowed_users``` - Allowed users to ssh. Defaults to shellless 'tunnel' user
  * ```vpc_id``` - ID of VPC to launch instances in
  * ```private_subnets``` - What subnets to allow EC2 to launch instances in
  * ```public_subnets``` - What subnets for ELB/ASG
  * ```ssh_port``` - Port for SSH to listen on
  * ```key_name``` - specify aws ssh key name to launch instance with
  * ```iam_instance_profile``` - specify an IAM instance profile
  * ```associate_public_ip_address``` - associate public ip address for EC2 instance

### Outputs

  * ```dns_name``` - DNS Name of the load balancer used to reach bastions
  * ```security_group``` - The security group id created and assigned to the bastion host
  * ```zone_id``` - The ELB Zone Id assigned to the load balancer. Used by Route53 for alias records.

### Example

```bash
module "bastion" {
  source = "github.com/BitGo/terraform-aws-bastion"
  version = "0.0.1"
  name = "bastion-abc"
  instance_type = "t2.nano"
  authorized_keys_directory = "keys/ssh/"
  authorized_key_names = ["alice", "bob", "mallory"]
  allowed_cidrs = ["0.0.0.0/0"]
  vpc_id = "vpc-123456"
  ssh_port = 22
  public_subnets = ["subnet-6789123"]
  private_subnets = ["subnet-123456", "subnet-321321"]
}
```
