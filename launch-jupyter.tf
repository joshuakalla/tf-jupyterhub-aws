provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# Allow incoming and outgoing traffic.
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create the AWS Instance.
resource "aws_instance" "jupyterhub" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  tags {
    Name = "jupyterhub"
  }

# Load JupyterHub on the instance.
  user_data = <<EOF
#!/bin/bash
curl https://raw.githubusercontent.com/jupyterhub/the-littlest-jupyterhub/master/bootstrap/bootstrap.py | sudo python3 - --admin admin
EOF

  security_groups = ["${aws_security_group.allow_all.name}"]
}

# Print the public DNS to access the instance.
output "dns" {
  value = "${aws_instance.jupyterhub.public_dns}"
}