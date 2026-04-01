# Upgrade Guide: azurerm to AzAPI

This module has migrated from the `azurerm` provider
(`azurerm_web_application_firewall_policy`) to the `azapi` provider
(`azapi_resource`). The variable interface is nearly identical — the
`managed_rules`, `custom_rules`, `policy_settings`, `lock`,
`role_assignments`, `tags`, and `enable_telemetry` variables are all
unchanged. The only input change is replacing `resource_group_name`
with `parent_id`.

## Breaking changes

- **`resource_group_name` replaced by `parent_id`** — supply the full
  ARM resource ID of the resource group instead of the name string.
- **`timeouts` variable removed** — the AzAPI provider manages
  timeouts internally.
- **Provider requirements** — `azapi` >= 2.7 is now required
  alongside `azurerm` >= 4.2.
- **Terraform >= 1.12** is required.
- **New output: `provisioning_state`** — exposes the current
  provisioning state from the ARM response.
- **`resource_id` output uses canonical ARM casing** — constructed
  via `provider::azapi::build_resource_id()`, which may differ in
  casing from the previous `azurerm` output.

## Variable mapping

| Old variable           | New variable | Notes                              |
|------------------------|--------------|------------------------------------|
| `resource_group_name`  | `parent_id`  | Full ARM resource ID required      |
| `timeouts`             | *(removed)*  | No replacement needed              |
| All other variables    | *(unchanged)* | `managed_rules`, `custom_rules`, `policy_settings`, `lock`, `role_assignments`, `tags`, `enable_telemetry` |

## Migration example

```hcl
# Before (azurerm-based module)
module "waf_policy" {
  source  = "Azure/avm-res-network-applicationgatewaywebapplicationfirewallpolicy/azurerm"
  version = "0.3.1"

  name                = "my-waf-policy"
  resource_group_name = "rg-example"
  location            = "uksouth"
  # ...
}

# After (AzAPI-based module)
module "waf_policy" {
  source  = "Azure/avm-res-network-applicationgatewaywebapplicationfirewallpolicy/azurerm"
  version = "0.4.0"

  name      = "my-waf-policy"
  parent_id = "/subscriptions/{sub-id}/resourceGroups/rg-example"
  location  = "uksouth"
  # ...
}
```

If you already have a resource group data source or module output:

```hcl
parent_id = data.azurerm_resource_group.example.id
```

## State migration

After updating your module source and variables, migrate the
Terraform state so the existing WAF policy is not destroyed and
recreated:

```bash
# 1. Remove the old resource from state
terraform state rm 'module.waf_policy.azurerm_web_application_firewall_policy.this'

# 2. Import the resource under the new AzAPI address
terraform import 'module.waf_policy.azapi_resource.this' \
  '/subscriptions/{sub-id}/resourceGroups/rg-example/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/my-waf-policy'
```

Replace `module.waf_policy` with whatever module address you use,
and substitute your actual subscription ID, resource group, and
policy name.

After importing, run `terraform plan` to confirm there are no
unexpected changes.

## Output changes

| Output              | Change                                           |
|---------------------|--------------------------------------------------|
| `resource_id`       | Now uses canonical ARM casing via `provider::azapi::build_resource_id()`. May differ in letter casing from the old `azurerm` output. |
| `provisioning_state`| **New.** Returns the current provisioning state.  |
| `name`              | Unchanged.                                       |
| `http_listener_ids` | Unchanged.                                       |
| `path_based_rule_ids`| Unchanged.                                      |
