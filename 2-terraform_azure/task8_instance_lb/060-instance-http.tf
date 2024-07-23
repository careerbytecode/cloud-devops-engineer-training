resource "azurerm_network_interface" "http" {
  for_each = var.vm_names

  name                = "nic-${each.value}"
  resource_group_name = azurerm_resource_group.generic.name
  location            = azurerm_resource_group.generic.location

  ip_configuration {
    name                          = "ip-config-${each.value}"
    subnet_id                     = azurerm_subnet.http.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "http" {
  for_each = var.vm_names

  name                  = each.value
  location              = azurerm_resource_group.generic.location
  resource_group_name   = azurerm_resource_group.generic.name
  network_interface_ids = [azurerm_network_interface.http[each.key].id]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk-${each.value}"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
    custom_data    = file("scripts/first-boot.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
