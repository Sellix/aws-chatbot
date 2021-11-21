data "local_file" "web-app-chatbot-cloudformation" {
  filename = "${path.module}/cloudformation.yml"
}

resource "aws_cloudformation_stack" "web-app-chatbot-slack-configuration" {
  name          = "sellix-web-app-chatbot-slack-configuration"
  template_body = data.local_file.web-app-chatbot-cloudformation.content
  parameters = {
    ConfigurationNameParameter = "web-app-chatbot-slack-configuration"
    IamRoleArnParameter        = aws_iam_role.web-app-chatbot-role.arn
    LoggingLevelParameter      = "ERROR"
    SlackChannelIdParameter    = var.slack_channel_id
    SlackWorkspaceIdParameter  = var.slack_workspace_id
    SnsTopicArnsParameter      = "${aws_sns_topic.web-app-eu-west-1-chatbot-sns-topic.arn},${aws_sns_topic.web-app-us-east-1-chatbot-sns-topic.arn}"
  }
  tags = local.tags
}

resource "aws_sns_topic" "web-app-us-east-1-chatbot-sns-topic" {
  provider = aws.us-east-1
  name     = "sellix-web-app-us-east-1-chatbot-sns-topic"
}

resource "aws_sns_topic" "web-app-eu-west-1-chatbot-sns-topic" {
  provider = aws
  name     = "sellix-web-app-eu-west-1-chatbot-sns-topic"
}

resource "aws_sns_topic_policy" "web-app-us-east-1-chatbot-sns-topic-policy" {
  provider = aws.us-east-1
  arn      = aws_sns_topic.web-app-us-east-1-chatbot-sns-topic.arn
  policy   = data.aws_iam_policy_document.web-app-us-west-1-chatbot-sns-policy-document.json
}

resource "aws_sns_topic_policy" "web-app-eu-west-1-chatbot-sns-topic-policy" {
  provider = aws
  arn      = aws_sns_topic.web-app-eu-west-1-chatbot-sns-topic.arn
  policy   = data.aws_iam_policy_document.web-app-eu-west-1-chatbot-sns-policy-document.json
}