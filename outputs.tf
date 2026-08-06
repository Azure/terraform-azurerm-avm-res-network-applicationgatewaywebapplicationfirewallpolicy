output "http_listener_ids" {
  description = "The ID of the HTTP Listeners associated with the WAF Policy."
  value       = try([for item in azapi_resource.this.output.properties.httpListeners : item.id], [])
}

output "name" {
  description = "The name of the WAF Policy."
  value       = azapi_resource.this.name
}

output "path_based_rule_ids" {
  description = "The ID of the Path Based Rules associated with the WAF Policy."
  value       = try([for item in azapi_resource.this.output.properties.pathBasedRules : item.id], [])
}

output "provisioning_state" {
  description = "The current provisioning state."
  value       = try(azapi_resource.this.output.properties.provisioningState, null)
}

output "resource_id" {
  description = "The ID of the WAF Policy, constructed with canonical ARM casing to prevent drift."
  value       = provider::azapi::build_resource_id(var.parent_id, "Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies", var.name)
}
