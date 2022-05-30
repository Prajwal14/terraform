# ###########################################################################
# ## S3 bucket for Client
# ###########################################################################

# resource "aws_s3_bucket" "client" {
#   bucket = "${local.naming}-react-client-fe"

#   tags = {
#     Environment = "Dev"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "block_client_public_access" {
#   bucket = aws_s3_bucket.client.id

#   block_public_acls   = true
#   block_public_policy = true
# }

# # resource "aws_s3_bucket_acl" "client_acl" {
# #   bucket = aws_s3_bucket.client.bucket
# #   acl    = "public-read"
# # }

# # resource "aws_s3_bucket_website_configuration" "client" {
# #   bucket = aws_s3_bucket.client.bucket

# #   index_document {
# #     suffix = "index.html"
# #   }

# #   error_document {
# #     key = "error.html"
# #   }
# # }


# ###########################################################################
# ## S3 bucket for Admin
# ###########################################################################

# resource "aws_s3_bucket" "admin" {
#   bucket = "${local.naming}-react-admin-fe"

#   tags = {
#     Environment = "Dev"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "block_admin_public_access" {
#   bucket = aws_s3_bucket.admin.id

#   block_public_acls   = true
#   block_public_policy = true
# }

# # resource "aws_s3_bucket_acl" "admin_acl" {
# #   bucket = aws_s3_bucket.admin.bucket
# #   acl    = "public-read"
# # }

# # resource "aws_s3_bucket_website_configuration" "admin" {
# #   bucket = aws_s3_bucket.admin.bucket

# #   index_document {
# #     suffix = "index.html"
# #   }

# #   error_document {
# #     key = "error.html"
# #   }
# # }