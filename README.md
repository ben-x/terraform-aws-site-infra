# Terraform AWS Site Infrastructure
This project provides the config to setup an infrastructure of a static website with S3 or S3 & Cloudfront


### Usage
```
module "site" {
  source = "./terraform-aws-site-infra"
  domains = ["site.com"]
  ssl_certificate_arn = "arn:aws:wafv2:us-east-1:1234567834:global/webacl/site-waf/93f2fe8f-223c-48ad-2387-0e0fea2c4a6c"
  deploy_with_cloudfront = false
  protocol = "redirect_http"
}
```

### Arguments
- source: (string|required) the path to the module on file system
- domain: (list|required) a list of domains to setup. Also uses this for the name of the s3 bucket.
- ssl_certificate_arn: (string|optional) the arn of aws ssl certificate if redirect to ssl is turned on
- deploy_with_cloudfront: (bool|optional) whether or not to setup cloudfront.
- protocol: (string|optional) which protocol to observe when serving the pages. possible values includes all, https and redirect_http

### Outputs
- s3_endpoints: a list of the created endpoints with which the sites can be accessed.
- cloudfront_domains: a list of the created cloudfront domains if cloudfront was enabled
