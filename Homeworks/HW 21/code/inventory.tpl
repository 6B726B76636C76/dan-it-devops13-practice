[web]
%{ for ip in web_ips ~}
${ip} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/ec2-key-task.pem
%{ endfor ~}