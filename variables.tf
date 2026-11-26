variable "aws_region"    { default = "ap-south-1" }
variable "ecr_repo_name" { default = "hdfc-app" }
variable "cluster_name"  { default = "hdfc-eks" }
variable "vpc_id"        { type = string }
variable "subnet_ids"    { type = list(string) }
