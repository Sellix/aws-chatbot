variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

variable "slack_channel_id" {
  description = "Slack Channel ID"
  default     = ""
}

variable "slack_workspace_id" {
  description = "Slack WorkSpace ID"
  default     = ""
}