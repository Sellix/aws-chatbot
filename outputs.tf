output "eu-west-1_chatbot-arn" {
  value = aws_sns_topic.web-app-eu-west-1-chatbot-sns-topic.arn
}

output "us-east-1_chatbot-arn" {
  value = aws_sns_topic.web-app-us-east-1-chatbot-sns-topic.arn
}