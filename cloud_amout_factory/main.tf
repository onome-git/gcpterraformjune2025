l\

      }
    ]
  ])
}
module "cloud_armor" {
  source = "./modules/cloud-armor"
  for_each     = { for policy in local.cloud_armor_list : "${policy.name}-${policy.project_id}" => policy }
  project_id = each.value.project_id
  name = each.value.name
  description = each.value.description
  json_parsing = each.value.json_parsing #"STANDARD"
  #Enable Adaptive Protection
  layer_7_ddos_defense_enable = each.value.layer_7_ddos_defense_enable #true
  layer_7_ddos_defense_rule_visibility = each.value.layer_7_ddos_defense_rule_visibility #"STANDARD"

  default_rule_action          = each.value.default_rule_action #"deny(404)"
  #Add pre-configured rules
  #Set target to lb backend
  pre_configured_rules = each.value.pre_configured_rules
  security_rules=each.value.security_rules
}
#example of cloud armor factory
