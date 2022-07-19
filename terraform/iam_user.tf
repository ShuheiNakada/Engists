# -------------------------------------------
# IAM user ※アクセスキーは手動で作成
# -------------------------------------------
resource "aws_iam_user" "rails" {
  name = "rails-on-fargate"
}

resource "aws_iam_user_policy" "rails" {
  name = "permission_to_access_s3"
  user = aws_iam_user.rails.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:PutObjectAcl"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}