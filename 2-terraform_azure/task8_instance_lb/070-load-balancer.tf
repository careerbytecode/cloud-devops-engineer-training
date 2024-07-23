resource "azurerm_lb" "http" {
  name                = "my-lb"
  resource_group_name = azurerm_resource_group.generic.name
  location            = azurerm_resource_group.generic.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "PrivateIPAddress"
    subnet_id                     = azurerm_subnet.http.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "http" {
  name            = "my-lb-backend-pool"
  loadbalancer_id = azurerm_lb.http.id
}

resource "azurerm_lb_probe" "http" {
  loadbalancer_id = azurerm_lb.http.id
  name            = "my-lb"
  port            = 80
  protocol        = "Tcp"
}

resource "azurerm_lb_rule" "http" {
  loadbalancer_id                = azurerm_lb.http.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.http.id]
  frontend_ip_configuration_name = azurerm_lb.http.frontend_ip_configuration[0].name
  name                           = "HTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  probe_id                       = azurerm_lb_probe.http.id
}

resource "azurerm_network_interface_backend_address_pool_association" "http" {
  for_each = var.vm_names

  network_interface_id    = azurerm_network_interface.http[each.key].id
  ip_configuration_name   = azurerm_network_interface.http[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.http.id
}
