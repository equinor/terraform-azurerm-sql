mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./tests/setup-unit-tests"
  }
}

run "sql_server_azuread_authentication_only_enabled" {
  command = plan

  variables {
    server_name                          = run.setup_tests.server_name
    resource_group_name                  = run.setup_tests.resource_group_name
    location                             = run.setup_tests.location
    log_analytics_workspace_id           = run.setup_tests.log_analytics_workspace_id
    azuread_administrator_login_username = run.setup_tests.azuread_administrator_login_username
    azuread_administrator_object_id      = run.setup_tests.azuread_administrator_object_id
    azuread_authentication_only          = true
  }

  assert {
    condition     = azurerm_mssql_server.this.azuread_administrator[0].login_username == run.setup_tests.azuread_administrator_login_username && azurerm_mssql_server.this.azuread_administrator[0].azuread_authentication_only == true
    error_message = "AzureAD authentication only not enabled"
  }
}

run "sql_server_azuread_authentication_only_disabled" {
  command = plan

  variables {
    server_name                          = run.setup_tests.server_name
    resource_group_name                  = run.setup_tests.resource_group_name
    location                             = run.setup_tests.location
    log_analytics_workspace_id           = run.setup_tests.log_analytics_workspace_id
    administrator_login                  = run.setup_tests.administrator_login
    azuread_administrator_login_username = run.setup_tests.azuread_administrator_login_username
    azuread_administrator_object_id      = run.setup_tests.azuread_administrator_object_id
    azuread_authentication_only          = false
  }

  assert {
    condition     = azurerm_mssql_server.this.administrator_login == run.setup_tests.administrator_login && azurerm_mssql_server.this.azuread_administrator[0].azuread_authentication_only == false
    error_message = "AzureAD authentication only not disabled"
  }
}
