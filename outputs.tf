output "plaintext_password" {
  description = "Plaintext password for the test instance."
  value       = var.get_password_data ? rsadecrypt(aws_instance.this.password_data, file("~/.ssh/id_rsa")) : ""
}

output "public_ip" {
  description = "Public IP address of the test instance."
  value       = aws_instance.this.public_ip
}
