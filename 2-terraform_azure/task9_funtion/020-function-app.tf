resource "random_id" "suffix" {
  byte_length = 8
}

resource "azurerm_storage_account" "this" {
  name                     = "san${random_id.suffix.hex}"
  resource_group_name      = azurerm_resource_group.generic.name
  location                 = azurerm_resource_group.generic.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "this" {
  name                = "app-service-plan"
  resource_group_name = azurerm_resource_group.generic.name
  location            = azurerm_resource_group.generic.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

data "archive_file" "this" {
  type        = "zip"
  source_dir  = "${path.module}/functions/"
  output_path = "${path.module}/functions.zip"
}

resource "terraform_data" "replacement" {
  input = data.archive_file.this.output_sha
}

resource "azurerm_linux_function_app" "this" {
  name                = "my-function-app-${random_id.suffix.hex}"
  resource_group_name = azurerm_resource_group.generic.name
  location            = azurerm_resource_group.generic.location
  storage_account_name        = azurerm_storage_account.this.name
  storage_account_access_key  = azurerm_storage_account.this.primary_access_key
  service_plan_id             = azurerm_service_plan.this.id
  functions_extension_version = "~4"
  zip_deploy_file             = data.archive_file.this.output_path

  site_config {
    application_insights_connection_string = azurerm_application_insights.this.connection_string
    application_insights_key               = azurerm_application_insights.this.instrumentation_key
    application_stack {
      python_version = "3.10"
    }
    cors {
      allowed_origins = ["https://portal.azure.com"]
    }
  }

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = true
    ENABLE_ORYX_BUILD              = true
    AzureWebJobsDisableHomepage    = true
    FUNCTIONS_WORKER_RUNTIME       = "python"
    MY_SETTINGS                    = "my-value"
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    replace_triggered_by = [
      terraform_data.replacement
    ]
  }
}

resource "azurerm_application_insights" "this" {
  name                = "my-function-app-${random_id.suffix.hex}"
  resource_group_name = azurerm_resource_group.generic.name
  location            = azurerm_resource_group.generic.location
  application_type    = "other"

  lifecycle {
    replace_triggered_by = [
      terraform_data.replacement
    ]
  }
}
