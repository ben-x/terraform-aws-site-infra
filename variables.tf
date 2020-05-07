variable "env" {
  default = "Build"
}

variable "domains" {
  description = "The domain names of the website"
  type = list(string)
}

variable "deploy_with_cloudfront" {
  description = "Whether or not to deploy the website with cloudfront"
  type = bool
  default = true
}

variable "ssl_certificate_arn" {
  description = "AWS certificate ARN for the domain"
  type = string
}

variable "waf_arn" {
  description = "WAF ARN in AWS global region"
  type = string
  default = null
}
