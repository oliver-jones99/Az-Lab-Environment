param adminUsername string
@secure()
param adminPassword string

// 1. Call NSG module → captures outputs
module nsg 'modules/nsg.bicep' = {
  name: 'nsgDeploy'
}

// 2. Call VNet module → pass in NSG IDs from step 1
module vnet 'modules/vnet.bicep' = {
  name: 'vnetDeploy'
  params: {
    nsgVnetAId: nsg.outputs.nsgVnetAId
    nsgVnetBId: nsg.outputs.nsgVnetBId
  }
}

// 3. Call Storage module
module storage 'modules/storage.bicep' = {
  name: 'storageDeploy'
}

// 4. Call VM module → pass in subnet IDs from step 2
module vm 'modules/vm.bicep' = {
  name: 'vmDeploy'
  params: {
    subnetA1Id: vnet.outputs.subnetA1Id
    subnetA2Id: vnet.outputs.subnetA2Id
    subnetB1Id: vnet.outputs.subnetB1Id
    createPublicIp: true
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}



