# -------------------------------------------
# S3: StaticBucket
# -------------------------------------------
resource "aws_s3_bucket" "s3_static_bucket" {
  bucket        = "${var.tool}-${var.project}-${var.environment}-static-bucket"
  force_destroy = true

  versioning {
    enabled = false
  }

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_static_bucket" {
  bucket                  = aws_s3_bucket.s3_static_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on = [
    aws_s3_bucket_policy.s3_static_bucket
  ]
}

resource "aws_s3_bucket_policy" "s3_static_bucket" {
  bucket = aws_s3_bucket.s3_static_bucket.id
  policy = data.aws_iam_policy_document.s3_static_bucket.json
}

data "aws_iam_policy_document" "s3_static_bucket" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_static_bucket.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cf_s3_origin_access_identity.iam_arn]
    }
  }
}

# -------------------------------------------
# S3: ImageStorageBucket
# -------------------------------------------
resource "aws_s3_bucket" "s3_image_storage_bucket" {
  bucket        = "${var.tool}-${var.project}-${var.environment}-image-storage-bucket"
  force_destroy = true

  versioning {
    enabled = false
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST"]
    allowed_origins = ["https://${var.domain}"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_public_access_block" "s3_image_storage_bucket" {
  bucket                  = aws_s3_bucket.s3_image_storage_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on = [
    aws_s3_bucket_policy.s3_image_storage_bucket
  ]
}

resource "aws_s3_bucket_policy" "s3_image_storage_bucket" {
  bucket = aws_s3_bucket.s3_image_storage_bucket.id
  policy = data.aws_iam_policy_document.s3_image_storage_bucket.json
}

data "aws_iam_policy_document" "s3_image_storage_bucket" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObjectAcl",
    ]
    resources = ["${aws_s3_bucket.s3_image_storage_bucket.arn}/*", aws_s3_bucket.s3_image_storage_bucket.arn]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.self.account_id}:user/rails-on-fargate"]
    }
  }
}

data "aws_caller_identity" "self" {}