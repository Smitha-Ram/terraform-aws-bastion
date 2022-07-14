terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
    ct = {
      source  = "poseidon/ct"
      version = "0.10.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
  }
}
