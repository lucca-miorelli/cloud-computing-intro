################################################################################
#                                   PROVIDERS                                  #
################################################################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"  # Specifies the source of the AWS provider plugin
      version = "~> 4.36"  # Specifies the required version of the AWS provider plugin
    }
  }
}


# Declare the provider
provider "aws" {
  region = "us-east-1"  # Specifies the AWS region to use
}


################################################################################
#                                   RESOURCES                                  #
################################################################################

######################################
#            EC2 Instance            #
######################################

# Create Instance
resource "aws_instance" "cloud-kt-instance" {
  ami                    = "ami-053b0d53c279acc90"  # Specifies the Amazon Machine Image (AMI) to use
  instance_type          = "t2.micro"  # Specifies the instance type
  key_name               = "cloud-kt-key-pair"  # Specifies the key pair to use for SSH access
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]  # Specifies the security group to associate with the instance
  user_data              = file("ec2-user-data.sh")  # Specifies the user data script to run on the instance

  tags = {
    Name      = "cloud-kt"  # Specifies the name tag for the instance
    Terraform = "true"  # Specifies a tag to indicate that the resource was created by Terraform
  }
}

# Create Security Group
resource "aws_security_group" "ec2_security_group" {
  name        = "cloud-kt-sg"  # Specifies the name of the security group
  description = "Allow SSH inbound traffic"  # Specifies the description of the security group

  # Inbound SSH from anywhere
  ingress {
    from_port   = 22  # Specifies the starting port for inbound traffic
    to_port     = 22  # Specifies the ending port for inbound traffic
    protocol    = "tcp"  # Specifies the protocol for inbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Specifies the source IP ranges (CIDR blocks) allowed for inbound traffic
  }

  # Inbound HTTP from anywhere
  ingress {
    from_port   = 80  # Specifies the starting port for inbound traffic
    to_port     = 80  # Specifies the ending port for inbound traffic
    protocol    = "tcp"  # Specifies the protocol for inbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Specifies the source IP ranges (CIDR blocks) allowed for inbound traffic
  }

  # Outbound HTTP to anywhere
  egress {
    from_port   = 0  # Specifies the starting port for outbound traffic
    to_port     = 0  # Specifies the ending port for outbound traffic
    protocol    = "-1"  # Specifies the protocol for outbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Specifies the destination IP ranges (CIDR blocks) allowed for outbound traffic
  }

  # Outbound HTTPS to anywhere
  egress {
    from_port   = 0  # Specifies the starting port for outbound traffic
    to_port     = 0  # Specifies the ending port for outbound traffic
    protocol    = "-1"  # Specifies the protocol for outbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Specifies the destination IP ranges (CIDR blocks) allowed for outbound traffic
  }
}


######################################
#            S3 Bucket               #
######################################

# # Create S3 Bucket
# resource "aws_s3_bucket" "static_website_bucket" {
#   bucket = "my-static-website-bucket-cloud-kt"  # Replace with your desired bucket name
  
#   tags = {
#     Name        = "Static Website Bucket"  # Specifies the name tag for the bucket
#     Environment = "Production"  # Specifies the environment tag for the bucket
#     Terraform   = "true"  # Specifies a tag to indicate that the resource was created by Terraform
#   }
# }

# # Configure bucket to allow public access
# resource "aws_s3_bucket_public_access_block" "static_website_public_access_block" {
#   bucket = aws_s3_bucket.static_website_bucket.id  # Specifies the ID of the S3 bucket

#   block_public_acls   = false  # Specifies if public ACLs are blocked
#   block_public_policy = false  # Specifies if public bucket policies are blocked
#   ignore_public_acls  = false  # Specifies if public ACLs should be ignored
#   restrict_public_buckets = false  # Specifies if public buckets are restricted
# }

# # Configure bucket policy to allow public access
# resource "aws_s3_bucket_policy" "static_website_policy" {
#   bucket = aws_s3_bucket.static_website_bucket.bucket  # Specifies the name of the S3 bucket

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

# # Configure bucket to host static website
# resource "aws_s3_bucket_website_configuration" "static_website_configuration" {
#   bucket = aws_s3_bucket.static_website_bucket.id  # Specifies the ID of the S3 bucket

#   index_document {
#     suffix = "index.html"  # Specifies the suffix for the index document file
#   }
# }
