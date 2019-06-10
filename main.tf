
# Example Usage 


variable "aws_region" {
  default = "us-east-2"
}

provider "aws" {
  // access_key
  // secret_key
  region = "${var.aws_region}"
}

module "vpc" {
  source = "github.com/satomikenta-org/terraform-VPC-module/blob/master/vpc"
  AWS_REGION = "${var.aws_region}"  
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"  // "vpc_id" is module's output name
}

