AWS ALB HTTP -> HTTPS redirection module
======================================

This module creates AWS Application Load Balancer as per provided parameters.

This module creates AWS Application Load Balancer Listener on port 80 and attaches to it microservice which performs redirections from HTTP -> HTTPS.

Module Input Variables
----------------------
- `name` - (string) - **REQUIRED** - Name used to identify the resource
- `alb_arn` - (string) - **REQUIRED** - ALB ARN which the Listener should attach to
- `vpc_id` - (string) - **REQUIRED** - VPC in which to start the service
- `aws_region` - (bool) - OPTIONAL - If true, the ALB will be internal; default: `true`

Usage
-----
```hcl
module "https_redirection" {
  source = "github.com/mergermarket/tf_https_redirection"

  name    = "https-redirection"
  vpc_id  = "vpc-12345678"
  alb_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188"
}
```
