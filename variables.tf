variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
  sensitive   = false
}

# variable "public_subnet" {
#     description = "cidr_publicsubnet"  
#     type = string
# }

# variable "private_subnet" {
#     description = "cidr_privatesubnet"
#     type = string
# }

variable "subnets" {
  description = "Subnets_Virginia"
  type        = list(string)
}

variable "tags" {
  description = "tags proyecto"
  type        = map(string)
}

variable "cidr" {
  description = "CIDR VPC"
  type        = string
}

variable "ec2_specs" {
    description = "Parametros EC2"
    type = map(string)
}

variable "enable_monitoring" {
    description = "Habilita el despliegue de este servidor"
    type = bool
}

variable "access_key" {

}

variable "secret_key" {

    }