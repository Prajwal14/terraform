##################################################################################
# OAI for CloudFront to access S3
##################################################################################

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "oai-${var.bucket-name}"
}


##################################################################################
# CloudFront Distribution
##################################################################################

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.bucket_domain_name #aws_s3_bucket.s3bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path

    }

    origin_shield {
      enabled              = true
      origin_shield_region = var.region

    }

  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.root_obj

  #   logging_config {
  #     include_cookies = false
  #     bucket = "${var.bucket-name}.s3.amazonaws.com"
  #     prefix = var.logs_prefix

  #   }

    aliases = [var.domain_aliases]

  default_cache_behavior {
    allowed_methods = [
      "DELETE",
      "GET",
      "HEAD",
      "OPTIONS",
      "PATCH",
      "POST",
    "PUT"]
    cached_methods = [
      "GET",
    "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"

    }
  }

  tags = {
    Environment = var.Environment
  }

  viewer_certificate {
    ssl_support_method             = "sni-only"
    cloudfront_default_certificate = false
    acm_certificate_arn            = var.acm_certificate_arn
  }
}


#####################################################################
# ADD BUCKET POLICY 
#####################################################################

resource "aws_s3_bucket_policy" "default" {
  bucket = var.bucket-name
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
      {
          "Sid": "1",
          "Effect": "Allow",
          "Principal": {
              "AWS": "${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"
          },
          "Action": "s3:GetObject",
          "Resource": "${var.bucket_arn}/*"
      }
  ]
}
POLICY 
}