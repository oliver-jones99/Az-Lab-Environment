

resource nicVma101 'Microsoft.Network/networkInterfaces@2025-05-01' = {
  name: 'vma101nic'
  location: 'eastus'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_vm_a1_01_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_VNet_A_name_Subnet_1.id
          }
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    nicType: 'Standard'
  }
}

resource nicVma201 'Microsoft.Network/networkInterfaces@2025-05-01' = {
  name: 'vma201nic'
  location: 'eastus'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_VNet_A_name_Subnet_2.id
          }
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    nicType: 'Standard'
  }
}

resource nicVmb101 'Microsoft.Network/networkInterfaces@2025-05-01' = {
  name: 'vmb101nic'
  location: 'eastus'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_VNet_B_name_Subnet_1.id
          }
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    nicType: 'Standard'
  }
}

