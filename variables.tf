# required
variable "name" {
  description = "Name used to identify the resource"
  type        = "string"
}

variable "alb_arn" {
  description = "If true, the LB will be internal"
  type        = "string"
}

variable "vpc_id" {
  description = "VPC in which to start the service"
  type        = "string"
}

# optional
variable "aws_region" {
  description = "AWS Region"
  default     = "eu-west-1"
}
