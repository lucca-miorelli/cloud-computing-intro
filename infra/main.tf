################################################################################
#                                   PROVIDERS                                  #
################################################################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.36"
    }
  }
}


# Declare the provider
provider "aws" {
  region = "us-east-1"
}


################################################################################
#                                   RESOURCES                                  #
################################################################################

######################################
#            EC2 Instance            #
######################################

# Create Instance
resource "aws_instance" "cloud-kt-instance" {

  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  key_name               = "cloud-kt-key-pair"
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  user_data              = file("ec2-user-data.sh")

  tags = {
    Name      = "cloud-kt"
    Terraform = "true"
  }
}

# Create Security Group
resource "aws_security_group" "ec2_security_group" {
  name        = "cloud-kt-sg"
  description = "Allow SSH inbound traffic"

  # Inbound SSH from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # CIDR, IP, SG
  }

  # Inbound HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound HTTP to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound HTTPS to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


######################################
#            S3 Bucket               #
######################################

# resource "aws_s3_bucket" "static_website_bucket" {
#   bucket = "my-static-website-bucket-cloud-kt"  # Replace with your desired bucket name
  
#   tags = {
#     Name        = "Static Website Bucket"
#     Environment = "Production"
#     Terraform   = "true"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "static_website_public_access_block" {
#   bucket = aws_s3_bucket.static_website_bucket.id

#   block_public_acls   = false
#   block_public_policy = false
#   ignore_public_acls  = false
#   restrict_public_buckets = false
# }


# resource "aws_s3_bucket_website_configuration" "static_website_configuration" {
#   bucket = aws_s3_bucket.static_website_bucket.id

#   index_document {
#     suffix = "index.html"  # Replace with your desired index file name
#   }
# }

# resource "aws_s3_bucket_policy" "static_website_policy" {
#   bucket = aws_s3_bucket.static_website_bucket.bucket

#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Principal": "*",
#         "Action": "s3:GetObject",
#         "Resource": "arn:aws:s3:::${aws_s3_bucket.static_website_bucket.bucket}/*"
#       }
#     ]
# }
# EOF
# }