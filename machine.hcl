provider "azurerm" {
  features {}
}

resource "azurerm_virtual_machine" "macos_build_agent" {
  name                = "macos-build-agent"
  location            = "West Europe"
  resource_group_name = "ci-cd-resources"
  vm_size             = "Standard_D2s_v3"

  os_profile {
    computer_name  = "cpu_tb"
    admin_username = "admin"
    admin_password = "__!"
  }

  tags = {
    environment = "ci"
    project     = "web4.si"
  }
}
