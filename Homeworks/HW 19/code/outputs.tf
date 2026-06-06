output "public_ec2_ip" {
  description = "Public IP of the public EC2 instance — use this to SSH in"
  value       = aws_instance.public.public_ip
}

output "private_ec2_ip" {
  description = "Private IP of the private EC2 instance — use this from inside the VPC"
  value       = aws_instance.private.private_ip
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "ssh_to_public" {
  description = "Command to SSH into public EC2"
  value       = "ssh -A -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.public.public_ip}"
}

output "ssh_to_private_via_jump" {
  description = "Command to SSH into private EC2 via public EC2 (ProxyJump)"
  value       = "ssh -J ec2-user@${aws_instance.public.public_ip} -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.private.private_ip}"
}
