data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnet" {
  name = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_network_interface" "nic" {
  name = var.nic_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_linux_virtual_machine" "vm" {
  name = var.vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  size = "Standard_D2_v2"
  admin_username = var.admin_username
  admin_password = "Werdabest@78"

  disable_password_authentication = false

  network_interface_ids = [
    data.azurerm_network_interface.nic.id
  ]

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name = "${var.vm_name}--osdisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "22.04-lts"
    version =  "latest"
  }

  computer_name = var.vm_name
}
