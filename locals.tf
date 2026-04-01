locals {
  role_definition_resource_substring = "/providers/Microsoft.Authorization/roleDefinitions"
}

locals {
  resource_body = {
    properties = {
      customRules = var.custom_rules == null ? null : [for key, item in var.custom_rules : {
        name               = item.name
        priority           = item.priority
        ruleType           = item.rule_type
        action             = item.action
        state              = item.enabled == false ? "Disabled" : "Enabled"
        groupRateLimitBy   = item.group_rate_limit_by
        rateLimitDuration  = item.rate_limit_duration
        rateLimitThreshold = item.rate_limit_threshold
        matchConditions = [for mc_key, mc in item.match_conditions : {
          matchVariables = [for mv in mc.match_variables : {
            variableName = mv.variable_name
            selector     = mv.selector
          }]
          operator         = mc.operator
          negationConditon = mc.negation_condition
          matchValues      = mc.match_values
          transforms       = mc.transforms == null ? null : [for t in mc.transforms : t]
        }]
      }]
      managedRules = {
        exclusions = var.managed_rules.exclusion == null ? null : [for key, item in var.managed_rules.exclusion : {
          matchVariable         = item.match_variable
          selectorMatchOperator = item.selector_match_operator
          selector              = item.selector
          exclusionManagedRuleSets = item.excluded_rule_set == null ? null : [{
            ruleSetType    = item.excluded_rule_set.type
            ruleSetVersion = item.excluded_rule_set.version
            ruleGroups = item.excluded_rule_set.rule_group == null ? null : [for rg in item.excluded_rule_set.rule_group : {
              ruleGroupName = rg.rule_group_name
              rules = rg.excluded_rules == null ? null : [for r in rg.excluded_rules : {
                ruleId = r
              }]
            }]
          }]
        }]
        managedRuleSets = [for key, item in var.managed_rules.managed_rule_set : {
          ruleSetType    = item.type
          ruleSetVersion = item.version
          ruleGroupOverrides = item.rule_group_override == null ? null : [for rgo_key, rgo in item.rule_group_override : {
            ruleGroupName = rgo.rule_group_name
            rules = rgo.rule == null ? null : [for r in rgo.rule : {
              ruleId = r.id
              action = r.action
              state  = r.enabled == false ? "Disabled" : "Enabled"
            }]
          }]
        }]
      }
      policySettings = var.policy_settings == null ? null : {
        state                             = var.policy_settings.enabled == false ? "Disabled" : "Enabled"
        mode                              = var.policy_settings.mode
        requestBodyCheck                  = var.policy_settings.request_body_check
        requestBodyEnforcement            = var.policy_settings.request_body_enforcement
        requestBodyInspectLimitInKB       = var.policy_settings.request_body_inspect_limit_in_kb
        maxRequestBodySizeInKb            = var.policy_settings.max_request_body_size_in_kb
        fileUploadLimitInMb               = var.policy_settings.file_upload_limit_in_mb
        jsChallengeCookieExpirationInMins = var.policy_settings.js_challenge_cookie_expiration_in_minutes
        logScrubbing = var.policy_settings.log_scrubbing == null ? null : {
          state = var.policy_settings.log_scrubbing.enabled == false ? "Disabled" : "Enabled"
          scrubbingRules = var.policy_settings.log_scrubbing.rule == null ? null : [for r in var.policy_settings.log_scrubbing.rule : {
            matchVariable         = r.match_variable
            selectorMatchOperator = r.selector_match_operator
            selector              = r.selector
            state                 = r.enabled == false ? "Disabled" : "Enabled"
          }]
        }
      }
    }
  }
}
