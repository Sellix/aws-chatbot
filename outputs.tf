output "chatbot_arn" {
  value = aws_sns_topic.web-app-slack-notifications.arn
}