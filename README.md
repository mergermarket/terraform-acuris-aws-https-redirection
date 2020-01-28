AWS ALB HTTP -> HTTPS redirection module
======================================

[![Build Status](https://travis-ci.org/mergermarket/terraform-acuris-aws-https-redirection.svg?branch=master)](https://travis-ci.org/mergermarket/terraform-acuris-aws-https-redirection)

This module creates AWS Application Load Balancer as per provided parameters.

This module creates AWS Application Load Balancer Listener on port 80 and attaches to it microservice which performs redirections from HTTP -> HTTPS.

Module Input Variables
----------------------

- `name` - (string) - **REQUIRED** - Name used to identify the resource
- `alb_arn` - (string) - **REQUIRED** - ALB ARN which the Listener should attach to
- `vpc_id` - (string) - **REQUIRED** - VPC in which to start the service

Usage
-----
```hcl
module "https_redirection" {
  source  = "mergermarket/ecs-https-redirection/acuris"
  version = "2.0.0"

  name    = "https-redirection"
  vpc_id  = "vpc-12345678"
  alb_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188"
}
```
