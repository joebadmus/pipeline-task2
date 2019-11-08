output "webserver_node_endpoint" {
  value = "http://${aws_instance.WebserverBox.public_ip}  To connect ssh -i key ec2-user@${aws_instance.WebserverBox.public_ip}"
}