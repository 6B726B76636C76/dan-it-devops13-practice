[jenkins_server]
${server_ip} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/ec2-key-task.pem jenkins_private_ip=${server_private_ip}

[jenkins_worker]
${worker_ip} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/ec2-key-task.pem ansible_ssh_common_args='-o ProxyJump=${server_ip}'