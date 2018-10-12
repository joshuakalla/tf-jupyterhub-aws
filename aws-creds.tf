variable "access_key" {}

variable "secret_key" {}

variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
	default = "ami-0ac019f4fcb7cb7e6"
}

variable "instance_type" {
	default = "t3.medium"
}