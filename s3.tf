resource "aws_s3_bucket" "my-bucket"{
    bucket = local.s3-sufix
}