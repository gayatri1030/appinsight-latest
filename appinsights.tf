resource "random_id" "app-insight" {
  byte_length = 4
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_template_deployment" "app-insights" {
  count               = var.app_insights_enable_log_analytics ? 0 : 1
  deployment_mode     = "Incremental"
  name                = "ApplicationInsights-${random_id.app-insight.hex}"
  resource_group_name = data.azurerm_resource_group.rg.name
  template_body       = file("${path.module}/azureappinsights.json")
  parameters = {
    app_insight_name                            = var.app_insights_name != "" ? "${var.app_insights_name}-${var.environment}-app-insights" : "${var.app_name}-${var.environment}-app-insights"
    app_insight_type                            = var.app_insights_type
    app_insight_location                        = var.location
    flow_type                                   = var.app_insights_flow_type
    request_source                  = var.app_insights_request_source
    ingestion_mode                  = "ApplicationInsights"
    publicNetworkAccessForIngestion = var.app_insights_public_network_access_for_ingestion
    publicNetworkAccessForQuery     = var.app_insights_public_network_access_for_query
  }


}

resource "azurerm_template_deployment" "app-insights-log-analytics" {
  count               = var.app_insights_enable_log_analytics ? 1 : 0
  deployment_mode     = "Incremental"
  name                = "ApplicationInsights-${random_id.app-insight.hex}"
  resource_group_name = data.azurerm_resource_group.rg.name
  template_body       = file("${path.module}/appinsightsloganalytics.json")
  parameters = {
    app_insight_name                            = var.app_insights_name != "" ? "${var.app_insights_name}-${var.environment}" : "${var.app_name}-${var.environment}"
    app_insight_type                            = var.app_insights_type
    app_insight_location                        = var.location
    workspace_id                                = var.app_insights_workspace_resource_id
    flow_type                                   = var.app_insights_flow_type
    request_source                  = var.app_insights_request_source
    ingestion_mode                  = "LogAnalytics"
    publicNetworkAccessForIngestion = var.app_insights_public_network_access_for_ingestion
    publicNetworkAccessForQuery     = var.app_insights_public_network_access_for_query
  }


}

locals {
  id = var.app_insights_enable_log_analytics ? azurerm_template_deployment.app-insights-log-analytics[*].outputs["appInsightID"] : azurerm_template_deployment.app-insights[*].outputs["appInsightsID"]
  trigger_id = join("", local.id)
}

resource "null_resource" "destroy" {
  triggers = {
    subscription_id = var.subscription_id
    tenant_id     = var.tenant_id
    client_id     = var.client_id
    client_secret = var.client_secret
    id            = local.trigger_id
  }

  provisioner "local-exec" {
    when = destroy
    command = <<SCRIPT
        az --version
        az login --service-principal --username ${self.triggers.client_id} --password "${self.triggers.client_secret}" --tenant ${self.triggers.tenant_id}
        az account set --subscription ${self.triggers.subscription_id}
        echo "DESTROYING APP INSIGHTS"
        echo "======================="
        az resource delete --ids ${self.triggers.id}

SCRIPT
  }
}
