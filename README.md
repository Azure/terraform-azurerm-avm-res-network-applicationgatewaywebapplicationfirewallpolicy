<!-- BEGIN_TF_DOCS -->
# Application Gateway Web Application Firewall Policy

This is a repo for the application gateway web application firewall policy.

> [!IMPORTANT]
> As the overall AVM framework is not GA (generally available) yet - the CI framework and test automation is not fully functional and implemented across all supported languages yet - breaking changes are expected, and additional customer feedback is yet to be gathered and incorporated. Hence, modules **MUST NOT** be published at version `1.0.0` or higher at this time.
>
> All module **MUST** be published as a pre-release version (e.g., `0.1.0`, `0.1.1`, `0.2.0`, etc.) until the AVM framework becomes GA.
>
> However, it is important to note that this **DOES NOT** mean that the modules cannot be consumed and utilized. They **CAN** be leveraged in all types of environments (dev, test, prod etc.). Consumers can treat them just like any other IaC module and raise issues or feature requests against them as they learn from the usage of the module. Consumers should also read the release notes for each version, if considering updating to a more recent version of a module to see if there are any considerations or breaking changes etc.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.5)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 3.71)

- <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) (~> 0.3)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.5)

## Resources

The following resources are used by this module:

- [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) (resource)
- [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_web_application_firewall_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy) (resource)
- [modtm_telemetry.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/resources/telemetry) (resource)
- [random_uuid.telemetry](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) (resource)
- [azurerm_client_config.telemetry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [modtm_module_source.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/data-sources/module_source) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_location"></a> [location](#input\_location)

Description: Azure region where the resource should be deployed.

Type: `string`

### <a name="input_managed_rules"></a> [managed\_rules](#input\_managed\_rules)

Description:
 ---
 `exclusion` block supports the following:
 - `match_variable` - (Required) The name of the Match Variable. Possible values: `RequestArgKeys`, `RequestArgNames`, `RequestArgValues`, `RequestCookieKeys`, `RequestCookieNames`, `RequestCookieValues`, `RequestHeaderKeys`, `RequestHeaderNames`, `RequestHeaderValues`.
 - `selector` - (Required) Describes field of the matchVariable collection.
 - `selector_match_operator` - (Required) Describes operator to be matched. Possible values: `Contains`, `EndsWith`, `Equals`, `EqualsAny`, `StartsWith`.

 ---
 `excluded_rule_set` block supports the following:
 - `type` - (Optional) The rule set type. Possible values are `Microsoft_DefaultRuleSet`, `Microsoft_BotManagerRuleSet` and `OWASP`. Defaults to `OWASP`.
 - `version` - (Optional) The rule set version. Possible values are `1.0` (for rule set type `Microsoft_BotManagerRuleSet`), `2.1` (for rule set type `Microsoft_DefaultRuleSet`) and `3.2` (for rule set type `OWASP`). Defaults to `3.2`.

 ---
 `rule_group` block supports the following:
 - `excluded_rules` - (Optional) One or more Rule IDs for exclusion.
 - `rule_group_name` - (Required) The name of rule group for exclusion. Possible values are `BadBots`, `crs_20_protocol_violations`, `crs_21_protocol_anomalies`, `crs_23_request_limits`, `crs_30_http_policy`, `crs_35_bad_robots`, `crs_40_generic_attacks`, `crs_41_sql_injection_attacks`, `crs_41_xss_attacks`, `crs_42_tight_security`, `crs_45_trojans`, `crs_49_inbound_blocking`, `General`, `GoodBots`, `KnownBadBots`, `Known-CVEs`, `REQUEST-911-METHOD-ENFORCEMENT`, `REQUEST-913-SCANNER-DETECTION`, `REQUEST-920-PROTOCOL-ENFORCEMENT`, `REQUEST-921-PROTOCOL-ATTACK`, `REQUEST-930-APPLICATION-ATTACK-LFI`, `REQUEST-931-APPLICATION-ATTACK-RFI`, `REQUEST-932-APPLICATION-ATTACK-RCE`, `REQUEST-933-APPLICATION-ATTACK-PHP`, `REQUEST-941-APPLICATION-ATTACK-XSS`, `REQUEST-942-APPLICATION-ATTACK-SQLI`, `REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION`, `REQUEST-944-APPLICATION-ATTACK-JAVA`, `UnknownBots`, `METHOD-ENFORCEMENT`, `PROTOCOL-ENFORCEMENT`, `PROTOCOL-ATTACK`, `LFI`, `RFI`, `RCE`, `PHP`, `NODEJS`, `XSS`, `SQLI`, `FIX`, `JAVA`, `MS-ThreatIntel-WebShells`, `MS-ThreatIntel-AppSec`, `MS-ThreatIntel-SQLI` and `MS-ThreatIntel-CVEs`. `MS-ThreatIntel-AppSec`, `MS-ThreatIntel-SQLI` and `MS-ThreatIntel-CVEs`.

 ---
 `managed_rule_set` block supports the following:
 - `type` - (Optional) The rule set type. Possible values: `Microsoft_BotManagerRuleSet`, `Microsoft_DefaultRuleSet` and `OWASP`. Defaults to `OWASP`.
 - `version` - (Required) The rule set version. Possible values: `0.1`, `1.0`, `2.1`, `2.2.9`, `3.0`, `3.1` and `3.2`.

 ---
 `rule_group_override` block supports the following:
 - `rule_group_name` - (Required) The name of the Rule Group. Possible values are `BadBots`, `crs_20_protocol_violations`, `crs_21_protocol_anomalies`, `crs_23_request_limits`, `crs_30_http_policy`, `crs_35_bad_robots`, `crs_40_generic_attacks`, `crs_41_sql_injection_attacks`, `crs_41_xss_attacks`, `crs_42_tight_security`, `crs_45_trojans`, `crs_49_inbound_blocking`, `General`, `GoodBots`, `KnownBadBots`, `Known-CVEs`, `REQUEST-911-METHOD-ENFORCEMENT`, `REQUEST-913-SCANNER-DETECTION`, `REQUEST-920-PROTOCOL-ENFORCEMENT`, `REQUEST-921-PROTOCOL-ATTACK`, `REQUEST-930-APPLICATION-ATTACK-LFI`, `REQUEST-931-APPLICATION-ATTACK-RFI`, `REQUEST-932-APPLICATION-ATTACK-RCE`, `REQUEST-933-APPLICATION-ATTACK-PHP`, `REQUEST-941-APPLICATION-ATTACK-XSS`, `REQUEST-942-APPLICATION-ATTACK-SQLI`, `REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION`, `REQUEST-944-APPLICATION-ATTACK-JAVA`, `UnknownBots`, `METHOD-ENFORCEMENT`, `PROTOCOL-ENFORCEMENT`, `PROTOCOL-ATTACK`, `LFI`, `RFI`, `RCE`, `PHP`, `NODEJS`, `XSS`, `SQLI`, `FIX`, `JAVA`, `MS-ThreatIntel-WebShells`, `MS-ThreatIntel-AppSec`, `MS-ThreatIntel-SQLI` and `MS-ThreatIntel-CVEs`MS-ThreatIntel-WebShells`,.

 ---
 `rule` block supports the following:
 - `action` - (Optional) Describes the override action to be applied when rule matches. Possible values are `Allow`, `AnomalyScoring`, `Block`, `JSChallenge` and `Log`. `JSChallenge` is only valid for rulesets of type `Microsoft\_BotManagerRuleSet`.
 - `enabled` - (Optional) Describes if the managed rule is in enabled state or disabled state. Defaults to `false`.
 - `id` - (Required) Identifier for the managed rule.
`

Type:

```hcl
object({
    exclusion = optional(map(object({
      match_variable          = string
      selector                = string
      selector_match_operator = string
      excluded_rule_set = optional(object({
        type    = optional(string)
        version = optional(string)
        rule_group = optional(list(object({
          excluded_rules  = optional(list(string))
          rule_group_name = string
        })))
      }))
    })))
    managed_rule_set = map(object({
      type    = optional(string)
      version = string
      rule_group_override = optional(map(object({
        rule_group_name = string
        rule = optional(list(object({
          action  = optional(string)
          enabled = optional(bool)
          id      = string
        })))
      })))
    }))
  })
```

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the this resource.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The resource group where the resources will be deployed.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_custom_rules"></a> [custom\_rules](#input\_custom\_rules)

Description:  - `action` - (Required) Type of action. Possible values are `Allow`, `Block` and `Log`.
 - `enabled` - (Optional) Describes if the policy is in enabled state or disabled state. Defaults to `true`.
 - `group_rate_limit_by` - (Optional) Specifies what grouping the rate limit will count requests by. Possible values are `GeoLocation`, `ClientAddr` and `None`.
 - `name` - (Optional) Gets name of the resource that is unique within a policy. This name can be used to access the resource.
 - `priority` - (Required) Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.
 - `rate_limit_duration` - (Optional) Specifies the duration at which the rate limit policy will be applied. Should be used with `RateLimitRule` rule type. Possible values are `FiveMins` and `OneMin`.
 - `rate_limit_threshold` - (Optional) Specifies the threshold value for the rate limit policy. Must be greater than or equal to 1 if provided.
 - `rule_type` - (Required) Describes the type of rule. Possible values are `MatchRule`, `RateLimitRule` and `Invalid`.

 ---
 `match_conditions` block supports the following:
 - `match_values` - (Optional) A list of match values. This is **Required** when the `operator` is not `Any`.
 - `negation_condition` - (Optional) Describes if this is negate condition or not
 - `operator` - (Required) Describes operator to be matched. Possible values are `Any`, `IPMatch`, `GeoMatch`, `Equal`, `Contains`, `LessThan`, `GreaterThan`, `LessThanOrEqual`, `GreaterThanOrEqual`, `BeginsWith`, `EndsWith` and `Regex`.
 - `transforms` - (Optional) A list of transformations to do before the match is attempted. Possible values are `HtmlEntityDecode`, `Lowercase`, `RemoveNulls`, `Trim`, `Uppercase`, `UrlDecode` and `UrlEncode`.

 ---
 `match_variables` block supports the following:
 - `selector` - (Optional) Describes field of the matchVariable collection
 - `variable_name` - (Required) The name of the Match Variable. Possible values are `RemoteAddr`, `RequestMethod`, `QueryString`, `PostArgs`, `RequestUri`, `RequestHeaders`, `RequestBody` and `RequestCookies`.

Type:

```hcl
map(object({
    action               = string
    enabled              = optional(bool)
    group_rate_limit_by  = optional(string)
    name                 = optional(string)
    priority             = number
    rate_limit_duration  = optional(string)
    rate_limit_threshold = optional(number)
    rule_type            = string
    match_conditions = map(object({
      match_values       = optional(list(string))
      negation_condition = optional(bool)
      operator           = string
      transforms         = optional(set(string))
      match_variables = list(object({
        selector      = optional(string)
        variable_name = string
      }))
    }))
  }))
```

Default: `null`

### <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key)

Description: A map describing customer-managed keys to associate with the resource. This includes the following properties:
- `key_vault_resource_id` - The resource ID of the Key Vault where the key is stored.
- `key_name` - The name of the key.
- `key_version` - (Optional) The version of the key. If not specified, the latest version is used.
- `user_assigned_identity` - (Optional) An object representing a user-assigned identity with the following properties:
  - `resource_id` - The resource ID of the user-assigned identity.

Type:

```hcl
object({
    key_vault_resource_id = string
    key_name              = string
    key_version           = optional(string, null)
    user_assigned_identity = optional(object({
      resource_id = string
    }), null)
  })
```

Default: `null`

### <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings)

Description: A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.

Type:

```hcl
map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.  
For more information see <https://aka.ms/avm/telemetryinfo>.  
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### <a name="input_lock"></a> [lock](#input\_lock)

Description: Controls the Resource Lock configuration for this resource. The following properties can be specified:

- `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.
- `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.

Type:

```hcl
object({
    kind = string
    name = optional(string, null)
  })
```

Default: `null`

### <a name="input_policy_settings"></a> [policy\_settings](#input\_policy\_settings)

Description:  - `enabled` - (Optional) Describes if the policy is in enabled state or disabled state. Defaults to `true`.
 - `file_upload_limit_in_mb` - (Optional) The File Upload Limit in MB. Accepted values are in the range `1` to `4000`. Defaults to `100`.
 - `js_challenge_cookie_expiration_in_minutes` - (Optional) Specifies the JavaScript challenge cookie validity lifetime in minutes. The user is challenged after the lifetime expires. Accepted values are in the range `5` to `1440`. Defaults to `30`.
 - `max_request_body_size_in_kb` - (Optional) The Maximum Request Body Size in KB. Accepted values are in the range `8` to `2000`. Defaults to `128`.
 - `mode` - (Optional) Describes if it is in detection mode or prevention mode at the policy level. Valid values are `Detection` and `Prevention`. Defaults to `Prevention`.
 - `request_body_check` - (Optional) Is Request Body Inspection enabled? Defaults to `true`.
 - `request_body_inspect_limit_in_kb` - (Optional) Specifies the maximum request body inspection limit in KB for the Web Application Firewall. Defaults to `128`.

 ---
 `log_scrubbing` block supports the following:
 - `enabled` - (Optional) Whether the log scrubbing is enabled or disabled. Defaults to `true`.

 ---
 `rule` block supports the following:
 - `enabled` - (Optional) Describes if the managed rule is in enabled state or disabled state. Defaults to `false`.
 - `match_variable` -
 - `selector` -
 - `selector_match_operator` -

Type:

```hcl
object({
    enabled                                   = optional(bool)
    file_upload_limit_in_mb                   = optional(number)
    js_challenge_cookie_expiration_in_minutes = optional(number)
    max_request_body_size_in_kb               = optional(number)
    mode                                      = optional(string)
    request_body_check                        = optional(bool)
    request_body_inspect_limit_in_kb          = optional(number)
    log_scrubbing = optional(object({
      enabled = optional(bool)
      rule = optional(list(object({
        enabled                 = optional(bool)
        match_variable          = string
        selector                = optional(string)
        selector_match_operator = optional(string)
      })))
    }))
  })
```

Default: `null`

### <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments)

Description: A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.

Type:

```hcl
map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: (Optional) Tags of the resource.

Type: `map(string)`

Default: `null`

### <a name="input_timeouts"></a> [timeouts](#input\_timeouts)

Description:  - `create` - (Defaults to 30 minutes) Used when creating the Web Application Firewall Policy.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Web Application Firewall Policy.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Web Application Firewall Policy.
 - `update` - (Defaults to 30 minutes) Used when updating the Web Application Firewall Policy.

Type:

```hcl
object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
```

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_http_listener_ids"></a> [http\_listener\_ids](#output\_http\_listener\_ids)

Description: The ID of the HTTP Listener associated with the WAF Policy.

### <a name="output_name"></a> [name](#output\_name)

Description: The name of the WAF Policy.

### <a name="output_path_based_rule_ids"></a> [path\_based\_rule\_ids](#output\_path\_based\_rule\_ids)

Description: The ID of the Path Based Rule associated with the WAF Policy.

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: The ID of the WAF Policy.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->