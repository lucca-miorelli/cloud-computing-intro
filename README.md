# Cloud Computing KT - Poatek Interns 2023/2

## Introduction
Welcome to the "cloud-computing intro" repository! This repository is aimed at introducing new interns at Poatek to cloud computing and Infrastructure as Code (IaC) concepts. In this KT, we will provide an overview of the infrastructure provisioning process with and without using Terraform, as well as some fundamental cloud concepts.

## Infrastructure Provisioning

### Infrastructure as Code (IaC)
Infrastructure as Code (IaC) is a practice of managing and provisioning infrastructure resources using declarative configuration files. It enables developers to define their infrastructure as code, which can be version controlled, shared, and automated. Terraform, one of the IaC tools, provides a way to define infrastructure resources in a declarative manner and provisions them efficiently.

### The `infra` Folder
In this repository, the infrastructure provisioning code is organized within the `infra` folder. This separation helps maintain a clean and structured project layout and facilitates better management of infrastructure-related files. The `infra` folder contains the following files:

- `main.tf`: This Terraform configuration file defines the infrastructure resources to be provisioned on AWS. It includes the provisioning of an EC2 instance and an S3 bucket to host a static website.
  
- `ec2-user-data.sh`: This file contains user data that will be passed to the EC2 instance during provisioning. It can be used to run custom scripts or commands on the instance as it starts up.
  
### Provisioning EC2 Instance
The `main.tf` file includes the configuration for creating an AWS EC2 instance. It specifies the required parameters such as AMI (Amazon Machine Image), instance type, security group, key pair, and user data script. A security group is also created to allow inbound SSH (port 22) and HTTP (port 80) traffic.

### Provisioning S3 Static Website
The `main.tf` file also configures the provisioning of an S3 bucket to host a static website. The bucket named "my-static-website-bucket-cloud-kt" is created, and necessary access policies are applied. The `aws_s3_bucket_website_configuration` resource defines the index document as "index.html," which will be served as the main page of the static website. Additionally, the `aws_s3_bucket_policy` resource allows public read access to the objects in the bucket.

## Repository Purpose
The purpose of this repository is to introduce new interns at Poatek to cloud computing and Infrastructure as Code (IaC) principles. By exploring this repo, interns can gain hands-on experience with provisioning infrastructure resources in the cloud using Terraform. The separation of the `infra` folder helps to keep the infrastructure-related code organized and easily manageable.

Please feel free to reach out to the mentors or ask questions if you need any further assistance in understanding or working with this repository. Enjoy your journey into the world of cloud computing and IaC!
