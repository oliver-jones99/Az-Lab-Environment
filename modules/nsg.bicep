param nsgVnetAName string = 'vnet-A-nsg'
param nsgVnetBName string = 'vnet-B-nsg'

resource nsgVnetA 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: nsgVnetAName
  location: 'eastus'
  properties: {
    securityRules: [
      {
        name: 'AllowRDPIn'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource nsgVnetB 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: nsgVnetBName
  location: 'eastus'
  properties: {
    securityRules: [
      {
        name: 'AllowRDPIn'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}

output nsgVnetAId string = nsgVnetA.id
output nsgVnetBId string = nsgVnetB.id
