terraform {
  backend "s3" {
    bucket = "terraform-deploy-fiap2024"
    key    = "backend/gtw/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_api_gateway_rest_api" "fastfood_api_gtw" {
  name        = "fastfood_api_gtw"
  description = "FastFood API Gateway"

  tags = {
    Name = "fastfood_api_gtw"
  }
}

resource "aws_api_gateway_resource" "gtw_resource" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api_gtw.id
  parent_id   = aws_api_gateway_rest_api.fastfood_api_gtw.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_authorizer" "lambda_authorizer" {
  name                   = "lambda_authorizer"
  rest_api_id            = aws_api_gateway_rest_api.fastfood_api_gtw.id
  authorizer_uri         = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:064151784429:function:fiap-tech-auth-dev-api/invocations"
  authorizer_credentials = "arn:aws:iam::064151784429:role/LabRole"
  type                   = "REQUEST"
}

resource "aws_api_gateway_method" "gtw_method" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api_gtw.id
  resource_id   = aws_api_gateway_resource.gtw_resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer.id
}

resource "aws_api_gateway_integration" "gtw_integration" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api_gtw.id
  resource_id = aws_api_gateway_resource.gtw_resource.id
  http_method = aws_api_gateway_method.gtw_method.http_method
  type        = "MOCK"
}