param location string = resourceGroup().location
param projectName string
param storageAccounts array = loadJsonContent('./storageconfig.json').values

var locationLength = length(location)

module storage 'storage/main.bicep' = [for config in storageAccounts: {
  name: '${deployment().name}-storage-${config.name}'
  params: {
    projectName: '${config.name}${projectName}'
    storageTier: config.tier
    location: location
    tags: {
      project: projectName
    }
  }
}]

output locationLengthMessage string = 'The location: ${location} has a ${locationLength} characters'
output projectNameMessage string = 'The project name is: ${projectName}'
output storageInputName string = storage[0].outputs.storageAccountName
output storageOutputName string = storage[1].outputs.storageAccountName

