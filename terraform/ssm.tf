# -------------------------------------------
# Systems Manager
# -------------------------------------------
resource "aws_ssm_parameter" "db_username" {
  name        = "/container-param/db-username"
  value       = "admin"
  type        = "SecureString"
  description = "MySQLのユーザー名"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/container-param/db-password"
  value       = "uninitialized"
  type        = "SecureString"
  description = "AWSCLIを用いて初期値から変更"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "db_host" {
  name        = "/container-param/db-host"
  value       = "uninitialized"
  type        = "SecureString"
  description = "AWSCLIを用いて初期値から変更"

  lifecycle {
    ignore_changes = [value]
  }
}