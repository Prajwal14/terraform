# resource "aws_s3_bucket" "bucket1" {
#   bucket = "bucket1"

#   tags = {
#     Name        = "My bucket 1"
#     Environment = "Dev"
#   }
# }

# resource "aws_s3_bucket" "bucket2" {
#   bucket = "bucket2"

#   tags = {
#     Name        = "My bucket 2"
#     Environment = "Dev"
#   }
# }

# resource "aws_s3_bucket_acl" "bucket1" {
#   bucket = aws_s3_bucket.bucket1.id
#   acl    = "private"
# }

# resource "aws_s3_bucket_acl" "bucket2" {
#   bucket = aws_s3_bucket.bucket2.id
#   acl    = "private"
# }
