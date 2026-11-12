# Avec le password grant, admin-cli permet de tester des identifiants sans passer par la page de login.
# Terraform passe par son propre client (client_credentials) : seul ensure-terraform-client.sh
# utilise admin-cli, pour créer ce client quand il n'existe pas encore.
# Avec import = true, le provider fusionne la config dans le client existant et un false
# y est écrasé par le true existant : le grant n'est coupé qu'au second apply.
resource "keycloak_openid_client" "admin_cli_pass_emploi" {
  realm_id                     = keycloak_realm.pass-emploi.id
  client_id                    = "admin-cli"
  name                         = "$${client_admin-cli}"
  import                       = true
  access_type                  = "PUBLIC"
  direct_access_grants_enabled = false
  full_scope_allowed           = false
}

resource "keycloak_openid_client" "admin_cli_master" {
  realm_id                     = keycloak_realm.master.id
  client_id                    = "admin-cli"
  name                         = "$${client_admin-cli}"
  import                       = true
  access_type                  = "PUBLIC"
  direct_access_grants_enabled = false
  full_scope_allowed           = false
}
