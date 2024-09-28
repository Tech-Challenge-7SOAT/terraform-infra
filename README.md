# FastFood API Gateway com Terraform

Este repositório contém a infraestrutura do Terraform para criar e gerenciar um API Gateway da AWS para um serviço EKS de um fast food.

## Descrição

A arquitetura proposta utiliza o AWS API Gateway para expor um endpoint público que redireciona todas as requisições para o serviço EKS. O API Gateway foi configurado com um caminho genérico `{proxy+}`, permitindo que todas as requisições sejam redirecionadas para o serviço EKS, passando pelo mesmo autorizador.

O autorizador é responsável por validar as requisições antes de serem encaminhadas ao serviço EKS. Isso garante que apenas requisições autenticadas e autorizadas possam acessar o serviço.

Além disso, foi criado um link VPC para permitir que o API Gateway se comunique com recursos dentro de uma VPC, como o serviço EKS. Isso proporciona um nível adicional de segurança, pois o tráfego entre o API Gateway e o serviço EKS não é exposto à internet pública.

A infraestrutura é gerenciada usando o Terraform, uma ferramenta de infraestrutura como código (IaC) que permite criar, alterar e melhorar a infraestrutura de forma segura e eficiente.

## Produto Final

O produto final desta arquitetura é um API Gateway seguro e escalável que serve como ponto de entrada para o serviço EKS, permitindo que o serviço seja acessado de forma segura e eficiente a partir da internet.