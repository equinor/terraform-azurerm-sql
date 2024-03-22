mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "basic" {
  command = plan

  variables {
    server_name                          = run.setup_tests.server_name
    resource_group_name                  = run.setup_tests.resource_group_name
    location                             = run.setup_tests.location
    log_analytics_workspace_id           = run.setup_tests.log_analytics_workspace_id
    azuread_administrator_login_username = run.setup_tests.azuread_administrator_login_username
    azuread_administrator_object_id      = run.setup_tests.azuread_administrator_object_id
    storage_account_id                   = run.setup_tests.storage_account_id
    storage_blob_endpoint                = run.setup_tests.storage_blob_endpoint
  }
}

run "complete" {
  command = plan

  variables {
    server_name                          = run.setup_tests.server_name
    resource_group_name                  = run.setup_tests.resource_group_name
    location                             = run.setup_tests.location
    log_analytics_workspace_id           = run.setup_tests.log_analytics_workspace_id
    azuread_administrator_login_username = run.setup_tests.azuread_administrator_login_username
    azuread_administrator_object_id      = run.setup_tests.azuread_administrator_object_id
    storage_account_id                   = run.setup_tests.storage_account_id
    storage_blob_endpoint                = run.setup_tests.storage_blob_endpoint
  }
}
