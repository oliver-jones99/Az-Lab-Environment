param vnetAName string = 'VNet-A'
param vnetBName string = 'VNet-B'

param nsgVnetAId string
param nsgVnetBId string

resource vnetA 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: vnetAName
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'Subnet-1'
        properties: {
          networkSecurityGroup: {
            id: nsgVnetAId
          }
          addressPrefixes: [
            '10.0.1.0/24'
          ]
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
      {
        name: 'Subnet-2'
        properties: {
          networkSecurityGroup: {
            id: nsgVnetAId
          }
          addressPrefixes: [
            '10.0.2.0/24'
          ]
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource vnetB 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: vnetBName
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'Subnet-1'
        properties: {
          networkSecurityGroup: {
            id: nsgVnetBId
          }
          addressPrefixes: [
            '10.1.1.0/24'
          ]
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

output subnetA1Id string = vnetA.properties.subnets[0].id
output subnetA2Id string = vnetA.properties.subnets[1].id
output subnetB1Id string = vnetB.properties.subnets[0].id
