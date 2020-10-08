data "local_file" "web-app-slack-cloudformation" {
  filename = "${path.module}/cloudformation-chatbot.yml"
}

resource "aws_cloudformation_stack" "web-app-slack-configuration" {
  name = "sellix-web-app-chatbot"
  template_body = data.local_file.web-app-slack-cloudformation.content
  parameters = {
    ConfigurationNameParameter = "sellix-web-app-chatbot"
    IamRoleArnParameter        = aws_iam_role.web-app-chatbot-role.arn
    LoggingLevelParameter      = "ERROR"
    SlackChannelIdParameter    = var.slack_channel_id
    SlackWorkspaceIdParameter  = var.slack_workspace_id
    SnsTopicArnsParameter      = aws_sns_topic.web-app-slack-notifications.arn
  }
  tags = local.tags
}

resource "aws_sns_topic" "web-app-slack-notifications" {
  name = "sellix-web-app-slack-notifications"
}

resource "aws_sns_topic_policy" "web-app-slack-policy" {
  arn    = aws_sns_topic.web-app-slack-notifications.arn
  policy = data.aws_iam_policy_document.web-app-slack-notifications.json
}