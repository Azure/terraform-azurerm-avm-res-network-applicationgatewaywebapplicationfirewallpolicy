terraform {
  required_version = "~> 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.74"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {}
}


## Section to provide a random Azure region for the resource group
# This allows us to randomize the region for the resource group.
module "regions" {
  source  = "Azure/avm-utl-regions/azurerm"
  version = "~> 0.1"
}

# This allows us to randomize the region for the resource group.
resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}
## End of section to provide a random Azure region for the resource group

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "~> 0.4"
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  location = module.regions.regions[random_integer.region_index.result].name
  name     = module.naming.resource_group.name_unique
}

# This is the module call
# Do not specify location here due to the randomization above.
# Leaving location as `null` will cause the module to use the resource group location
# with a data source.
module "test" {
  source = "../../"
  # source             = "Azure/avm-<res/ptn>-<name>/azurerm"
  # ...
  location            = azurerm_resource_group.this.location
  name                = module.naming.firewall_policy.name_unique
  resource_group_name = azurerm_resource_group.this.name

  managed_rules = {
    exclusion = {
      example_exclusion = {
        match_variable          = "RequestHeaderNames"
        selector                = "/request/headers/x-forwarded-for"
        selector_match_operator = "Equals"
        excluded_rule_set = {
          type    = "OWASP"
          version = "3.2"
          rule_group = [{
            rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
            excluded_rules  = ["942100", "942120"]
          }]
        }
      }
    }
    managed_rule_set = {
      example_rule_set = {
        type    = "OWASP"
        version = "3.2"
        rule_group_override = {
          sql_injection_group = {
            rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
            rule = [{
              id      = "942100"
              action  = "Block"
              enabled = true
            }]
          }
        }
      }
    }
  }


  custom_rules = {
    example_rule_1 = {
      action               = "Block"
      enabled              = true
      group_rate_limit_by  = "ClientAddr"
      name                 = "RateLimitExample"
      priority             = 1
      rate_limit_duration  = "OneMin"
      rate_limit_threshold = 100
      rule_type            = "RateLimitRule"
      match_conditions = {
        condition_1 = {
          match_values       = ["192.168.1.1", "192.168.1.2"]
          negation_condition = false
          operator           = "Equal"
          transforms         = ["Lowercase"]
          match_variables = [
            {
              selector      = "/request/headers/x-forwarded-for"
              variable_name = "RequestHeaders"
            }
          ]
        }
      }
    }
  }

  policy_settings = {
    enabled                                   = true
    file_upload_limit_in_mb                   = 100
    js_challenge_cookie_expiration_in_minutes = 60
    max_request_body_size_in_kb               = 128
    mode                                      = "Prevention"
    request_body_check                        = true
    request_body_inspect_limit_in_kb          = 64
    log_scrubbing = {
      enabled = true
      rule = [{
        enabled                 = true
        match_variable          = "RequestHeaderNames"
        selector                = "Authorization"
        selector_match_operator = "Equals"
      }]
    }
  }

  timeouts = {
    create = "30m"
    delete = "30m"
    read   = "5m"
    update = "30m"
  }

  lock = {
    kind = "CanNotDelete"
    name = "resource-lock"
  }

  enable_telemetry = var.enable_telemetry # see variables.tf
}
