output "vpc_name" {
  value = module.vpc.vpc_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "instance_id" {
  description = "The unique identifier for the provisioned EC2 instance."
  value       = module.ec2.instance_id
}
output "instance_state" {
  value = module.ec2.instance_state
}

output "instance_type" {
  description = "The type of EC2 instance (e.g., t2.micro, m5.large)."
  value       = module.ec2.instance_type
}

output "public_dns" {
  description = "The public DNS name assigned to the EC2 instance."
  value       = module.ec2.public_dns
}

output "public_ip" {
  description = "The public IP address assigned to the EC2 instance."
  value       = module.ec2.public_ip
}

output "private_dns" {
  description = "The private DNS name assigned to the EC2 instance within its VPC."
  value       = module.ec2.private_dns
}

output "private_ip" {
  description = "The private IP address assigned to the EC2 instance within its VPC."
  value       = module.ec2.private_ip
}

