
output "ssh_connection_string_for_ec2" {
  value = "ssh -i ~/.ssh/jenkins_demo ubuntu@${module.jenkins.dev_proj_1_ec2_instance_public_ip}"
}
