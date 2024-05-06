param projectName string
param location string
param tags object = {}
@allowed([
  'LRS'
  'ZRS'
])
param storageTier string

var storageAccountNameDirty = 'stor${toLower(projectName)}'
var salt = substring(uniqueString(resourceGroup().id, deployment().name), 0, 3)
var storageAccountName = '${substring(replace(storageAccountNameDirty, '-', ''), 0, 19)}${salt}'
var storageTierName = 'Standard_${storageTier}'
var combinedTags = union(tags, {originalAccountName: storageAccountNameDirty, originalTier: storageTier})

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  kind: 'StorageV2'
  location: location
  tags: combinedTags
  sku: {
    name: storageTierName
  }
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    isHnsEnabled: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

output storageAccountName string = storageAccountName
output storageTierName string = storageTierName



// resource storageAccounts_anbolearnstor20_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-04-01' = {
//   parent: storageAccounts_anbolearnstor20_name_resource
//   name: 'default'
//   sku: {
//     name: 'Standard_ZRS'
//     tier: 'Standard'
//   }
//   properties: {
//     containerDeleteRetentionPolicy: {
//       enabled: true
//       days: 7
//     }
//     cors: {
//       corsRules: []
//     }
//     deleteRetentionPolicy: {
//       allowPermanentDelete: false
//       enabled: true
//       days: 7
//     }
//   }
// }

// resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_anbolearnstor20_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-04-01' = {
//   parent: storageAccounts_anbolearnstor20_name_resource
//   name: 'default'
//   sku: {
//     name: 'Standard_ZRS'
//     tier: 'Standard'
//   }
//   properties: {
//     protocolSettings: {
//       smb: {}
//     }
//     cors: {
//       corsRules: []
//     }
//     shareDeleteRetentionPolicy: {
//       enabled: true
//       days: 7
//     }
//   }
// }

// resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_anbolearnstor20_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-04-01' = {
//   parent: storageAccounts_anbolearnstor20_name_resource
//   name: 'default'
//   properties: {
//     cors: {
//       corsRules: []
//     }
//   }
// }

// resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_anbolearnstor20_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-04-01' = {
//   parent: storageAccounts_anbolearnstor20_name_resource
//   name: 'default'
//   properties: {
//     cors: {
//       corsRules: []
//     }
//   }
// }
