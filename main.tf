resource "aws_s3_bucket" "main" {
  for_each = toset(var.domains)

  bucket = each.value
  acl = "public-read"

  versioning {
    enabled = true
  }

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name = "${each.value} bucket"
    Environment = var.env
  }

  policy = <<POLICY
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Sid":"PublicReadGetObject",
         "Effect":"Allow",
         "Principal":"*",
         "Action":[
            "s3:GetObject"
         ],
         "Resource":[
            "arn:aws:s3:::${each.value}/*"
         ]
      }
   ]
}
POLICY
}


