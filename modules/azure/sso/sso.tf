data "azuread_client_config" "this" {}

resource "azuread_application" "this" {
  display_name = var.application

  owners = [
    data.azuread_client_config.this.object_id
  ]

  required_resource_access {
    resource_app_id = local.microsoft_graph
    resource_access {
      id   = local.api_permission_user_read_all
      type = "Role"
    }
  }

  dynamic "app_role" {
    for_each = var.roles
    content {
      allowed_member_types = ["User"]
      display_name         = app_role.value["name"]
      description          = app_role.value["description"]
      id                   = app_role.value["id"]
      value = app_role.value["name"]
    }
  }

  group_membership_claims = [
    "ApplicationGroup"
  ]

  optional_claims {
    id_token {
      name = "groups"
      essential = true
    }
  }

  web {
    redirect_uris = [
      var.redirect_uri
    ]

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }
}

resource "azuread_application_password" "this" {
  application_object_id = azuread_application.this.object_id
}
