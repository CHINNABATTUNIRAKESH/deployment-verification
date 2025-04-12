provider "aws" {
  region = "us-west-2" # Change this to your preferred region
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-075686beab831bb7f" # Replace with a valid Ubuntu AMI for your region
  instance_type = "t2.small"

  vpc_security_group_ids = ["sg-0a76d30209f78079c"] # Replace with your security group ID
  key_name               = "default-ec2" # Replace with your key pair name

  tags = {
    Name = "Terraform-Jenkins-Server"
  }
}

output "jenkins_server_ip" {
  value = aws_instance.jenkins_server.public_ip
}
