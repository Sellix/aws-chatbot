data "local_file" "web-app-chatbot-cloudformation" {
  filename = "${path.module}/cloudformation.yml"
}

resource "aws_cloudformation_stack" "web-app-chatbot-slack-configuration" {
  name = "sellix-web-app-chatbot-slack-configuration"
  template_body = data.local_file.web-app-chatbot-cloudformation.content
  parameters = {
    ConfigurationNameParameter = "web-app-chatbot-slack-configuration"
    IamRoleArnParameter        = aws_iam_role.web-app-chatbot-role.arn
    LoggingLevelParameter      = "ERROR"
    SlackChannelIdParameter    = var.slack_channel_id
    SlackWorkspaceIdParameter  = var.slack_workspace_id
    SnsTopicArnsParameter      = aws_sns_topic.web-app-chatbot-sns-topic.arn
  }
  tags = local.tags
}

resource "aws_sns_topic" "web-app-chatbot-sns-topic" {
  name = "sellix-web-app-chatbot-sns-topic"
}

resource "aws_sns_topic_policy" "web-app-chatbot-sns-topic-policy" {
  arn    = aws_sns_topic.web-app-chatbot-sns-topic.arn
  policy = data.aws_iam_policy_document.web-app-chatbot-sns-policy-document.json
}