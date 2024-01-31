resource "aws_sqs_queue" "localdev_aadejanovs_demo_queue" {
  name = "localdev_aadejanovs_demo_queue"
  visibility_timeout_seconds = 3
}

resource "aws_sqs_queue_policy" "localdev_aadejanovs_demo_queue_policy" {
  queue_url = aws_sqs_queue.localdev_aadejanovs_demo_queue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.localdev_aadejanovs_demo_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.localdev_aadejanovs_message_bus.arn}"
        }
      }
    }
  ]
}
POLICY
}
