variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "slack_channel_id" {
  description = "Slack Channel ID"
  default     = null
}

variable "slack_workspace_id" {
  description = "Slack WorkSpace ID"
  default     = null
}