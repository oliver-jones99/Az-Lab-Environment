param subnetA1Id string
param subnetA2Id string
param subnetB1Id string

param createPublicIp bool = false

param adminUsername string
@secure()
param adminPassword string

resource publicIp 'Microsoft.Network/publicIPAddresses@2025-05-01' = if (createPublicIp) {
  name: 'vm-a1-01-pip'
  location: 'eastus'
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource nicVma101 'Microsoft.Network/networkInterfaces@2025-05-01' = {
  name: 'vma101nic'
  location: 'eastus'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: createPublicIp ? { id: publicIp.id } : null
          subnet: {
            id: subnetA1Id
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
            id: subnetA2Id
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
            id: subnetB1Id
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

resource vmA101 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: 'vm-a1-01'
  location: 'eastus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-g2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: 'vm-a1-01-osdisk'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: 'vm-A1-01'
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicVma101.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
  }
}

resource vmA201 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: 'vm-a2-01'
  location: 'eastus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-g2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: 'vm-a2-01-osdisk'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: 'vm-A2-01'
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicVma201.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
  }
}

resource vmB101 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: 'vm-b1-01'
  location: 'eastus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-g2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: 'vm-B1-01-osdisk'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: 'vm-B1-01'
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicVmb101.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
  }
}
