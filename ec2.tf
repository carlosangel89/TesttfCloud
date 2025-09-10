# Con COUNT
# variable "instances" {
#   description = "Instances Name"
#   type = list(string)
#   default = [ "apache","jumpserver","mysql" ]  
# }

# resource "aws_instance" "public_instance" {
#   count = length(var.instances)
#   ami             = var.ec2_specs.ami
#   instance_type   = var.ec2_specs.instance_type
#   subnet_id       = aws_subnet.public_subnet.id
#   key_name        = data.aws_key_pair.keyec2.key_name
#   vpc_security_group_ids = [aws_security_group.EC2_instance.id]
#   tags = {
#     Name = var.instances[count.index]
#   }
#   user_data = file("scripts/userdata.sh")
# }


# Con For Each
variable "instances" {
  description = "Instances Name"
  type = set(string)
  default = [ "apache","mysql","jumpserver" ]  
}

resource "aws_instance" "public_instance" {
  for_each = var.instances
  # Si fuese una variable de tipo lista podemos transformarla con un for_each = toset(var.instances)
  ami             = var.ec2_specs.ami
  instance_type   = var.ec2_specs.instance_type
  subnet_id       = aws_subnet.public_subnet.id
  key_name        = data.aws_key_pair.keyec2.key_name
  vpc_security_group_ids = [aws_security_group.EC2_instance.id]
  tags = {
    Name = "${each.value}-${local.sufix}"
  }
  user_data = file("scripts/userdata.sh")
}

# Estructura condicional
resource "aws_instance" "monitoring_instance" {
  count = var.enable_monitoring ? 2 : 0 # booleana en este caso crearia 2 si es verdadero y 0 si es falso
  # count = var.enable_monitoring == 1 ? 1 : 0 # numerica
  ami             = var.ec2_specs.ami
  instance_type   = var.ec2_specs.instance_type
  subnet_id       = aws_subnet.public_subnet.id
  key_name        = data.aws_key_pair.keyec2.key_name
  vpc_security_group_ids = [aws_security_group.EC2_instance.id]
  tags = {
    Name = "Monitoreo-${local.sufix}"
  }
  user_data = file("scripts/userdata.sh")
}