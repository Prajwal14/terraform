# ###########################################################################
# ## Get Zone ID of Route53 HostedZone
# ###########################################################################

# data "aws_route53_zone" "bluwyre" {
#   name         = "devapp.bluwyre.io"
#   private_zone = false
# }

# ###########################################################################
# ## Module Call for Client CloudFront with ACM certificate
# ###########################################################################

# data "aws_acm_certificate" "client_cert" {
#   domain   = "client.devapp.bluwyre.io"
#   types    = ["AMAZON_ISSUED"]
#   statuses = ["ISSUED"]
# }

# module "cloudfront_client" {
#   source = "../modules/cloudfront"

#   bucket-name        = aws_s3_bucket.client.id
#   bucket_arn         = aws_s3_bucket.client.arn
#   bucket_domain_name = aws_s3_bucket.client.bucket_regional_domain_name

#   region      = var.region
#   root_obj    = "index.html"
#   Environment = var.env
#   price_class = "PriceClass_All"

#   domain_aliases = "client.devapp.bluwyre.io"

#   # PUT THE ARN OF YOUR AWS CERTIFICATE MUST BE IN VIRGINIA REGION
#   acm_certificate_arn = data.aws_acm_certificate.client_cert.arn
# }

# resource "aws_route53_record" "client_record" {
#   zone_id = data.aws_route53_zone.bluwyre.zone_id
#   name    = "client"
#   type    = "A"

#   alias {
#     name                   = module.cloudfront_client.domain_name
#     zone_id                = module.cloudfront_client.hosted_zone_id
#     evaluate_target_health = false
#   }
# }

# ###########################################################################
# ## Module Call for Admin CloudFront with ACM certificate
# ###########################################################################

# data "aws_acm_certificate" "admin_cert" {
#   domain   = "admin.devapp.bluwyre.io"
#   types    = ["AMAZON_ISSUED"]
#   statuses = ["ISSUED"]
# }

# module "cloudfront_admin" {
#   source = "../modules/cloudfront"

#   bucket-name        = aws_s3_bucket.admin.id
#   bucket_arn         = aws_s3_bucket.admin.arn
#   bucket_domain_name = aws_s3_bucket.admin.bucket_regional_domain_name

#   region      = var.region
#   root_obj    = "index.html"
#   Environment = var.env
#   price_class = "PriceClass_All"

#   domain_aliases = "admin.devapp.bluwyre.io"

#   # PUT THE ARN OF YOUR AWS CERTIFICATE MUST BE IN VIRGINIA REGION
#   acm_certificate_arn = data.aws_acm_certificate.admin_cert.arn
# }

# resource "aws_route53_record" "admin_record" {
#   zone_id = data.aws_route53_zone.bluwyre.zone_id
#   name    = "admin"
#   type    = "A"

#   alias {
#     name                   = module.cloudfront_admin.domain_name
#     zone_id                = module.cloudfront_admin.hosted_zone_id
#     evaluate_target_health = false
#   }
# }