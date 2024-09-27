resource "aws_cloudwatch_log_group" "api_gtw_log_group" {
  name = "/aws/apigateway/${var.api_name}"
}