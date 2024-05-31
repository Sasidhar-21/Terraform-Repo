variable "env" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "region" {
  type = string
}
variable "project" {}
variable "ec2_ami" {
  default = "ami-0fc5d935ebf8bc3bc"
}
variable "key_name" {}
variable "user_data" {
  default = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install git
              apt-get install -y apt-transport-https ca-certificates curl software-properties-common
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
              add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
              apt-get update -y
              apt-get install -y docker-ce
              systemctl enable docker
              systemctl start docker
              EOF
}
