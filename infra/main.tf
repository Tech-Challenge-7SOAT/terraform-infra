terraform {
  backend "s3" {
    bucket = "terraform-deploy-fiap2024"
    key    = "backend/gtw/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_api_gateway_rest_api" "fastfood_api_gtw" {
  name        = var.api_name
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
  identity_source        = "method.request.header.cpf"
  authorizer_result_ttl_in_seconds = 0
}

resource "aws_api_gateway_method" "gtw_method" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api_gtw.id
  resource_id   = aws_api_gateway_resource.gtw_resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer.id
}

resource "aws_api_gateway_integration" "gtw_integration" { // Apagar quando tiver o EKS pronto e descomentar os valores abaixo
  rest_api_id = aws_api_gateway_rest_api.fastfood_api_gtw.id
  resource_id = aws_api_gateway_resource.gtw_resource.id
  http_method = aws_api_gateway_method.gtw_method.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

#resource "aws_apigatewayv2_vpc_link" "fastfood_gtw_vpc_link" {
#  name        = "${var.api_name}-vpc_link"
#
#  security_group_ids = [var.SG_ID]
#  subnet_ids = [var.SUBNET_AZ_1, var.SUBNET_AZ_2, var.PRIVATE_SUBNET_1, var.PRIVATE_SUBNET_2]
#
#  target_arns = [var.NLB_LISTENER] //Colocar o valor dessa secret no github quando tiver o NLB
# // adicionar -var "NLB_LISTENER=${{ secrets.NLB_LISTENER }}" no comando de deploy do arquivo deploy.yml nas steps "Plan" e "Apply"
# // descomentar em variables.tf a variável NLB_LISTENER
#
#  tags = {
#    Name = "fastfood_gtw_vpc_link"
#  }
#}
#
#resource "aws_api_gateway_integration" "gtw_integration" {
#  rest_api_id = aws_api_gateway_rest_api.fastfood_api_gtw.id
#  resource_id = aws_api_gateway_resource.gtw_resource.id
#  http_method = aws_api_gateway_method.gtw_method.http_method
#
#  type                    = "HTTP_PROXY"
#  integration_http_method = "ANY"
#  uri                     = "http://mockapi.io/v1/your_mock_endpoint" //uri = "http://${aws_eks_cluster.your_cluster.endpoint}"
#
#  connection_type = "VPC_LINK"
#  connection_id   = aws_apigatewayv2_vpc_link.fastfood_gtw_vpc_link.id
#
#  passthrough_behavior = "WHEN_NO_MATCH"
#
#  request_templates = {
#    "application/json" = "{\"statusCode\": 200}"
#  }
#}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.gtw_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.fastfood_api_gtw.id
  stage_name  = "dev"
  stage_description = "Development Stage"
  description = "This is a deployment for the development stage."
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api_gtw.id
  stage_name    = "DEV"

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gtw_log_group.arn
    format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId"
  }
}