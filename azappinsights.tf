module "azappinsights" {
  source                          = "../../Terraform_Modules/AzureAppInsights"
  resource_group_name             = var.usr_resource_group_name
  environment                     = var.usr_environment
  location                        = var.usr_location
  tags                            = jsonencode(var.usr_tags)

  #AppInsight Variables
  app_insights_name                                = var.usr_app_insights_name
  app_insights_type                                = var.usr_app_insights_type
  app_insights_enable_log_analytics                = var.usr_app_insights_enable_log_analytics
  app_insights_workspace_resource_id               = var.usr_app_insights_workspace_resource_id
  app_insights_flow_type                           = var.usr_app_insights_flow_type
  app_insights_request_source                      = var.usr_app_insights_request_source
  app_insights_public_network_access_for_ingestion = var.usr_app_insights_public_network_access_for_ingestion
  app_insights_public_network_access_for_query     = var.usr_app_insights_public_network_access_for_query

  #Provider
  subscription_id  = var.usr_subscription_id
  tenant_id        = var.usr_tenant_id
  client_id        = var.usr_client_id
  client_secret    = var.usr_client_secret

}