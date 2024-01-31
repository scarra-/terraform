resource "aws_sns_topic" "localdev_aadejanovs_message_bus" {
  name = "aadejanovs_message_bus"
}

resource "aws_sns_topic_subscription" "localdev_aadejanovs_demo_sqs_target" {
  topic_arn = aws_sns_topic.localdev_aadejanovs_message_bus.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.localdev_aadejanovs_demo_queue.arn
}
