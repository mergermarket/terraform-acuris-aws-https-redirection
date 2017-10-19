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
module "alb_test" {
  source = "github.com/mergermarket/tf_alb"

  # required
  name                     = "foobar-alb"
  vpc_id                   = "vpc-2f09a348"
  subnet_ids               = ["subnet-b46032ec", "subnet-ca4311ef", "subnet-ba881221"]
  default_target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-targets/73e2d6bc24d8a067"
  certificate_domain_name  = "*.acuris.com"
}
```
