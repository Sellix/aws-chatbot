data "aws_iam_policy_document" "web-app-chatbot-assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type = "Service"
      identifiers = [
        "chatbot.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "web-app-slack-notifications" {
  statement {
    actions = ["sns:Publish"]
    principals {
      type = "Service"
      identifiers = [
        "codestar-notifications.amazonaws.com"
      ]
    }
    resources = [aws_sns_topic.web-app-slack-notifications.arn]
  }
}

data "aws_iam_policy_document" "web-app-chatbot-policy-document" {
  statement {
    actions = [
        "cloudwatch:Describe*",
        "cloudwatch:Get*",
        "cloudwatch:List*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "web-app-chatbot-role" {
  name = "sellix-web-app-chatbot-role"
  assume_role_policy = data.aws_iam_policy_document.web-app-chatbot-assume.json
}

resource "aws_iam_policy" "web-app-chatbot-policy" {
  name        = "sellix-web-app-chatbot-policy"
  path        = "/"
  policy      = data.aws_iam_policy_document.web-app-chatbot-policy-document.json
}

resource "aws_iam_role_policy_attachment" "web-app-chatbot-role-policy-attachment" {
  role       = aws_iam_role.web-app-chatbot-role.id
  policy_arn = aws_iam_policy.web-app-chatbot-policy.arn
}