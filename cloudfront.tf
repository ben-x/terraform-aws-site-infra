resource "aws_cloudfront_distribution" "main" {
  for_each = var.deploy_with_cloudfront == true ? toset(var.domains) : []

  origin {
    domain_name = aws_s3_bucket.main[each.value].bucket_regional_domain_name
    origin_id = aws_s3_bucket.main[each.value].id
  }

  enabled = true
  is_ipv6_enabled  = true
  comment = "Cloud front controller for ${aws_s3_bucket.main[each.value].id} bucket"
  default_root_object = "index.html"

  /*
  logging_config {
    include_cookies = false
    bucket = "ribytrail"
    prefix = aws_s3_bucket.main[each.value].id
  }
  */

  aliases = [aws_s3_bucket.main[each.value].id]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.main[each.value].id
    compress = true

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      //locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Description = "Cloud fron for Websites"
    Environment = "build"
  }

  viewer_certificate {
    acm_certificate_arn = var.ssl_certificate_arn
    minimum_protocol_version = "TLSv1.2_2018"
    ssl_support_method = "sni-only"
  }

  custom_error_response {
    error_code = 404
    response_code = 200
    error_caching_min_ttl = 300
    response_page_path = "/index.html"
  }

  web_acl_id = var.waf_arn
}
