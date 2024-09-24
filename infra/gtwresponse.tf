resource "aws_api_gateway_gateway_response" "default_4xx" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api_gtw.id
  status_code   = "400"
  response_type = "DEFAULT_4XX"

  response_templates = {
    "application/json" = "{\"message\": $context.error.messageString}"
  }
}

resource "aws_api_gateway_gateway_response" "default_5xx" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api_gtw.id
  status_code   = "500"
  response_type = "DEFAULT_5XX"

  response_templates = {
    "application/json" = "{\"message\": $context.error.messageString}"
  }
}

resource "aws_api_gateway_gateway_response" "unauthorized" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api_gtw.id
  status_code   = "401"
  response_type = "UNAUTHORIZED"

  response_templates = {
    "application/json" = "{\"message\": \"Unauthorized\"}"
  }
}

resource "aws_api_gateway_gateway_response" "access_denied" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api_gtw.id
  status_code   = "403"
  response_type = "ACCESS_DENIED"

  response_templates = {
    "application/json" = "{\"message\": \"Access Denied\"}"
  }
}