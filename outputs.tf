output "http_listener_ids" {
  description = "The ID of the HTTP Listener associated with the WAF Policy."
  value       = azurerm_web_application_firewall_policy.this.http_listener_ids
}

output "name" {
  description = "The name of the WAF Policy."
  value       = azurerm_web_application_firewall_policy.this.name
}

output "path_based_rule_ids" {
  description = "The ID of the Path Based Rule associated with the WAF Policy."
  value       = azurerm_web_application_firewall_policy.this.path_based_rule_ids
}

output "resource_id" {
  description = "The ID of the WAF Policy."
  value       = azurerm_web_application_firewall_policy.this.id
}
