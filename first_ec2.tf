provider "aws" {
region = "ap-south-1"
access_key = "AKIA4P3LZA5N7UTZN6UC"
secret_key = "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"
}

resource "aws_instance" "myec2" {
ami = "ami-041db4a969fe3eb68"
instance_type = "t2.micro"

}

resource "aws_eip" "lb" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id
  allocation_id = aws_eip.lb.id
}

resource "aws_security_group" "allow_tls" {
  name        = "kplabs-security-group"

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks =  ["${aws_eip.lb.public_ip}/32"]

  }
}
