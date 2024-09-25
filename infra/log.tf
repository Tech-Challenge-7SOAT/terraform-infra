resource "aws_cloudwatch_log_group" "api_gtw_log_group" {
  name = "/aws/apigateway/${var.api_name}"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.mock_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.fastfood_api_gtw.id
  stage_name  = "dev"
  stage_description = "Development Stage"
  description = "This is a deployment for the development stage."
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api_gtw.id
  stage_name    = "dev"

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gtw_log_group.arn
    format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId"
  }
}

