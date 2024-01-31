resource "aws_sns_topic" "message_bus" {
  name = "staging_message_bus"
}

resource "aws_sns_topic_subscription" "demo_sqs_target" {
  topic_arn = aws_sns_topic.message_bus.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.demo_queue.arn
}
