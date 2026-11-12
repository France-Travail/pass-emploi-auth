locals {
  brute_force_detection = {
    permanent_lockout                = false
    max_login_failures               = 5
    wait_increment_seconds           = 60 * 10
    quick_login_check_milli_seconds  = 1000
    minimum_quick_login_wait_seconds = 60
    max_failure_wait_seconds         = 60 * 60 * 24
    failure_reset_time_seconds       = 60 * 60 * 24 * 7
  }
}

import {
  to = keycloak_realm.master
  id = "master"
}

# Seul le brute force est géré sur master : les attributs ignorés seraient sinon remis
# à la valeur par défaut du provider (vide) au premier apply.
resource "keycloak_realm" "master" {
  realm        = "master"
  enabled      = true
  display_name = "Keycloak"

  security_defenses {
    brute_force_detection {
      permanent_lockout                = local.brute_force_detection.permanent_lockout
      max_login_failures               = local.brute_force_detection.max_login_failures
      wait_increment_seconds           = local.brute_force_detection.wait_increment_seconds
      quick_login_check_milli_seconds  = local.brute_force_detection.quick_login_check_milli_seconds
      minimum_quick_login_wait_seconds = local.brute_force_detection.minimum_quick_login_wait_seconds
      max_failure_wait_seconds         = local.brute_force_detection.max_failure_wait_seconds
      failure_reset_time_seconds       = local.brute_force_detection.failure_reset_time_seconds
    }
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      display_name_html,
      default_signature_algorithm,
      password_policy,
      smtp_server,
      internationalization,
      login_theme,
      account_theme,
      admin_theme,
      email_theme,
    ]
  }
}
