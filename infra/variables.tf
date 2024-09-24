variable "AWS_ACCESS_KEY_ID" {
  description = "The AWS access key"
  type        = string
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "The AWS secret access"
  type        = string
  sensitive   = true
}

variable "AWS_SESSION_TOKEN" {
  description = "The AWS session token"
  type        = string
  sensitive   = true
}

variable "AWS_REGION" {
  description = "The AWS region"
  type        = string
}

variable "SG_ID" {
  description = "The security group ID"
  type        = string
}

variable "SUBNET_AZ_1" {
  description = "First availability zone for the subnet (AZs-1)"
  type        = string
}

variable "SUBNET_AZ_2" {
  description = "Second availability zone for the subnet (AZs-2)"
  type        = string
}

variable "PRIVATE_SUBNET_1" {
  type        = string
}

variable "PRIVATE_SUBNET_2" {
  type        = string
}

#variable "NLB_LISTENER" {
#  type = string
#}

variable "api_name" {
  description = "The name of the API"
  type = string
  default = "fastfood_api"
}