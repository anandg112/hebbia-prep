module "s3_role" {
  source = "cloudposse/iam-role/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.19.0"

  enabled   = true
  namespace = "hebbia"
  stage     = "dev"
  name      = "sync-app"

  policy_description = "Allow S3 FullAccess"
  role_description   = "IAM role with permissions to perform actions on S3 resources"

  principals = {
    "Service" = ["lambda.amazonaws.com"]
  }

  policy_documents = [
    data.aws_iam_policy_document.s3_full_access.json,
    data.aws_iam_policy_document.s3_base.json
  ]
}

data "aws_iam_policy_document" "s3_base" {
  statement {
    sid = "BaseAccess"

    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = ["*"]
    effect    = "Allow"

  }
}

data "aws_iam_policy_document" "s3_full_access" {
  statement {
    sid       = "FullAccess"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:GetBucketLocation",
      "s3:AbortMultipartUpload"
    ]
  }
}
