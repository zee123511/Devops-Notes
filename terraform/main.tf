data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  address_space = ["10.22.16.0/21"]
  location = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name = var.subnet_name
  virtual_network_name = resource.azurerm_virtual_network.vnet.name
  resource_group_name = data.azurerm_resource_group.rg.name
  address_prefixes = ["10.22.16.0/24"]
}

resource "azurerm_public_ip" "pubip" {
  count               = length(var.vm_names)
  name                = "${var.vm_names[count.index]}-pip"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "nic" {
  count = length(var.vm_names)
  name = var.vm_names[count.index]
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location

  ip_configuration{
    name  = "internal"
    subnet_id  = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pubip[count.index].id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count = length(var.vm_names)
  name = var.vm_names[count.index]
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  size = "Standard_D2_v3"
  admin_username = var.admin_username
  admin_password = "Werdabest@78"

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name = "${var.vm_names[count.index]}--osdisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version =  "latest"
  }

  computer_name = var.vm_names[count.index]
}

output "vm_names" {
  value = azurerm_linux_virtual_machine.vm[*].name
}
