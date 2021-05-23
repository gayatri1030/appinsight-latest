
variable "resource_group_name" {
  default = "The name of the resource group in which to create the Application Insights component."
}

variable "app_name" {
  default = ""
}

variable "environment" {
  type = string
  description = "Environment for which the resource is being created, dev, uat, prod"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
}

variable "tags" {
  default = {}
}

variable "app_insights_name" {
  description = "Specifies the name of the Application Insights component."
  default = ""
}

variable "app_insights_type" {
  default = ""
}

variable "app_insights_enable_log_analytics" {
  default = ""
}

variable "app_insights_workspace_resource_id" {
  default = ""
}

variable "app_insights_flow_type" {
  default = ""
}

variable "app_insights_request_source" {
  default = ""
}

variable "app_insights_public_network_access_for_ingestion" {
  default = ""
}

variable "app_insights_public_network_access_for_query" {
  default = ""
}

variable "subscription_id" {
  type = string
  description = "Azure subscription id, could be skipped in case using azure service connection in ADO terraform task"
  default = null
}

variable "client_id" {
  type = string
  description = "Service principal Client IDcould be skipped in case using azure service connection in ADO terraform task"
  default = null
}

variable "client_secret" {
  type = string
  description = "Service Principal Client Secret,could be skipped in case using azure service connection in ADO terraform task"
  default = null
}

variable "tenant_id" {
  type = string
  description = "Azure tenant ID,could be skipped in case using azure service connection in ADO terraform task"
  default = null
}
