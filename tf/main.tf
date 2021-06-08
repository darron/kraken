data "aws_caller_identity" "current" {}

resource "aws_iam_role" "prod-ci-role" {
    name = "prod-ci-role"
    assume_role_policy = data.aws_iam_policy_document.prod-ci-policy.json
}

data "aws_iam_policy_document" "prod-ci-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    principals {
        type = "AWS"
        identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_iam_group" "prod-ci-group" {
    name = "prod-ci-group"
}

resource "aws_iam_user" "prod-ci-user" {
    name = "prod-ci-user"
}

resource "aws_iam_group_membership" "prod-ci" {
    name = "prod-ci"

    users = [
        aws_iam_user.prod-ci-user.name
    ]

    group = aws_iam_group.prod-ci-group.name
}

data "aws_iam_policy_document" "prod-ci-group-policy" {
    statement {
        actions = ["sts:AssumeRole"]
        resources = [aws_iam_role.prod-ci-role.arn]
    }
}

resource "aws_iam_group_policy" "prod-ci-group-policy" {
    name = "prod-ci-group-policy"
    group = "prod-ci-group"
    policy = data.aws_iam_policy_document.prod-ci-group-policy.json
}