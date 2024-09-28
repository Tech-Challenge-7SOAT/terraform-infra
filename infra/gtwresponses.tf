resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api_gtw.id
  resource_id = aws_api_gateway_resource.gtw_resource.id
  http_method = aws_api_gateway_method.gtw_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "response_integ_200" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api_gtw.id
  resource_id = aws_api_gateway_resource.gtw_resource.id
  http_method = aws_api_gateway_method.gtw_method.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  selection_pattern = "2[0-9]{2}"

  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_method_response" "response_403" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api_gtw.id
  resource_id = aws_api_gateway_resource.gtw_resource.id
  http_method = aws_api_gateway_method.gtw_method.http_method
  status_code = "403"
}

resource "aws_api_gateway_integration_response" "response_integ_403" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api_gtw.id
  resource_id = aws_api_gateway_resource.gtw_resource.id
  http_method = aws_api_gateway_method.gtw_method.http_method
  status_code = aws_api_gateway_method_response.response_403.status_code

  selection_pattern = "Deny"

  response_templates = {
    "application/json" = ""
  }
}