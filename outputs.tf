output "s3_endpoints" {
  value = [for bucket in aws_s3_bucket.main : bucket.website_endpoint]
}

output "cloudfront_domains" {
  value = [for site in aws_cloudfront_distribution.main : site.domain_name]
}
