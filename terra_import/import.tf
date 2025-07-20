resource "azurerm_managed_disk" "disk1" {
  for_each            = toset(var.vm_names)
  name                = each.value
  location            = "Central India"  # Replace if different
  resource_group_name = "rg01"           # Your RG name

  # Leave other fields empty for now; they'll be filled later
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 30
} 
