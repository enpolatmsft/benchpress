param name string = 'kvbenchpresstest'
param location string = resourceGroup().location

resource vault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: name
  location: location
  properties: {
    accessPolicies:[]
    enableRbacAuthorization: false
    enableSoftDelete: false
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

resource key 'Microsoft.KeyVault/vaults/keys@2022-07-01' = {
  parent: vault
  name: 'samplekey'
  properties: {
    kty: 'RSA'
    keyOps: []
    keySize: 2048
    curveName: 'P-521'
  }
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2022-07-01' = {
  parent: vault
  name: 'samplesecret'
  properties: {
    contentType: 'text/plain'
    value: 'samplevalue'
  }
}
