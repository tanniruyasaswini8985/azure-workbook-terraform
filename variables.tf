variable "subscription_id" {
  description = "Azure subscription ID to deploy into."
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev or prod)."
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be dev or prod."
  }
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "centralindia"
}

variable "workload_name" {
  description = "Short workload name used in resource names."
  type        = string
  default     = "monitoring"
}

variable "log_retention_days" {
  description = "Log Analytics data retention in days (30 to 730)."
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_days >= 30 && var.log_retention_days <= 730
    error_message = "Retention must be between 30 and 730 days."
  }
}

variable "tags" {
  description = "Extra tags applied to every resource."
  type        = map(string)
  default     = {}
}
