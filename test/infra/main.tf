module "https_redirection" {
    source  = "../.."
    
    name    = "test"
    alb_arn = ""
    vpc_id  = ""
}

provider "aws" {
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_get_ec2_platforms      = true
  skip_region_validation      = true
  skip_requesting_account_id  = true
  max_retries                 = 1
  access_key                  = "a"
  secret_key                  = "a"
  region                      = "eu-west-1"
  version                     = "1.60.0"
}