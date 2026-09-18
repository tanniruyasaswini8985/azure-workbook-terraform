locals {
  base_name = "${var.workload_name}-${var.environment}"

  common_tags = merge(var.tags, {
    environment = var.environment
    managed_by  = "terraform"
    project     = "azure-workbook-automation"
  })
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.base_name}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "law-${local.base_name}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days
  tags                = local.common_tags
}

locals {
  workbook_json = templatefile("${path.module}/workbook.json.tpl", {
    workspace_id = azurerm_log_analytics_workspace.this.id
    environment  = var.environment
  })
}

resource "azurerm_application_insights_workbook" "operations" {
  name                = uuidv5("url", "${local.base_name}-operations-workbook")
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  display_name        = "Operations Overview (${var.environment})"
  source_id           = lower(azurerm_log_analytics_workspace.this.id)
  data_json           = local.workbook_json
  tags                = local.common_tags
}
