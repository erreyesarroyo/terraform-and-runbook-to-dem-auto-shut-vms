#####Configure resources (three VMs on two subnets) to test the automation account->runbook in azure. May configure two if using limited account but it will show the runbook effects eitherway######

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg01"
  location = "EAST US"
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

# Subnets
resource "azurerm_subnet" "subnet_a" {
  name                 = "subnet_a"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet_b" {
  name                 = "subnet_b"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Network Interfaces
resource "azurerm_network_interface" "nic01" {
  name                = "nic01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_a.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "nic02" {
  name                = "nic02"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_b.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "nic03" {
  name                = "nic03"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_b.id
    private_ip_address_allocation = "Dynamic"
  }
}

# VMs
resource "azurerm_windows_virtual_machine" "vm01" {
  name                  = "vm01"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_B2s"
  admin_username        = "adminuser"
  admin_password        = "Pa$$word1234!"
  network_interface_ids = [azurerm_network_interface.nic01.id, ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
# The tags are critical in the fact that they must be identical to the way they depicted on the script to use on the runbook.
  tags = {
    auto_stop = "on"
  }
}

resource "azurerm_windows_virtual_machine" "vm02" {
  name                  = "vm02"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_B2s"
  admin_username        = "adminuser"
  admin_password        = "Pa$$word1234!"
  network_interface_ids = [azurerm_network_interface.nic02.id, ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = {
    auto_stop = "on"
  }
}

resource "azurerm_windows_virtual_machine" "vm03" {
  name                  = "vm03"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_B2s"
  admin_username        = "adminuser"
  admin_password        = "Pa$$word1234!"
  network_interface_ids = [azurerm_network_interface.nic03.id, ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = {
    auto_stop = "on"
  }
}
