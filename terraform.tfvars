virginia_cidr = "10.20.0.0/16"
# public_subnet = "10.20.0.0/24" -> string
# private_subnet = "10.20.1.0/24" -> string
subnets = ["10.20.0.0/24", "10.20.1.0/24"]
tags = {
  "owner"       = "Carlos"
  "env"         = "dev"
  "cloud"       = "AWS"
  "iac"         = "Terraform"
  "iac_version" = "1.13.1"
  "project"     = "tokiota"
  "region"      = "virginia"
}

cidr = "0.0.0.0/0"

ec2_specs = {
  "ami" = "ami-00ca32bbc84273381"
  "instance_type" = "t3.micro"
}

enable_monitoring = true