output "resource_group_name" {
  description = "Name of the resource group."
  value       = azurerm_resource_group.this.name
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.this.id
}

output "workbook_id" {
  description = "Resource ID of the deployed Azure Workbook."
  value       = azurerm_application_insights_workbook.operations.id
}
