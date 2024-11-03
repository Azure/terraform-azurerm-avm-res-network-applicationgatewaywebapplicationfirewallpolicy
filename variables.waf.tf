variable "managed_rules" {
  type = object({
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
  description = <<DESCRIPTION

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
 - `action` - (Optional) Describes the override action to be applied when rule matches. Possible values are `Allow`, `AnomalyScoring`, `Block`, `JSChallenge` and `Log`. `JSChallenge` is only valid for rulesets of type `Microsoft_BotManagerRuleSet`.
 - `enabled` - (Optional) Describes if the managed rule is in enabled state or disabled state. Defaults to `false`.
 - `id` - (Required) Identifier for the managed rule.
DESCRIPTION
  nullable    = false
}

variable "custom_rules" {
  type = map(object({
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
  default     = null
  description = <<DESCRIPTION
 - `action` - (Required) Type of action. Possible values are `Allow`, `Block` and `Log`.
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
DESCRIPTION
}

variable "policy_settings" {
  type = object({
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
  default     = null
  description = <<DESCRIPTION
 - `enabled` - (Optional) Describes if the policy is in enabled state or disabled state. Defaults to `true`.
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
DESCRIPTION
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default     = null
  description = <<DESCRIPTION
 - `create` - (Defaults to 30 minutes) Used when creating the Web Application Firewall Policy.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Web Application Firewall Policy.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Web Application Firewall Policy.
 - `update` - (Defaults to 30 minutes) Used when updating the Web Application Firewall Policy.
DESCRIPTION
}
