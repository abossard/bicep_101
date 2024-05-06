# How to get started

```bash
az login --use-device-code --tenant 71e5c115-3495-455a-9188-279967248a3d
az account set --subscription "007d573b-7f7e-4406-a4b8-d8b232b5ecad"
az account show
az deployment group create --name mytest --resource-group anbo-learning --template-file ./infra/main.bicep --parameter projectName=myProject
az bicep generate-params --file infra/main.bicep
az deployment group create --name mytest --resource-group anbo-learning --template-file ./infra/main.bicep --parameters \@infra/main.parameters.json
```