# Azure Lab Environment

## Description

This environment is designed to be a basic infrastructure template which I can deploy quickly to test lower level principles in preparation for AZ-104.

## To launch in azure:

Clone the repo to cloudshell:

> 'git clone https://github.com/oliver-jones99/Az-Lab-Environment.git'  
> 'cd Az-Lab-Environment'

Create a new resource in the appropriate resource group from the main.bicep file:

> 'New-AzResourceGroupDeployment -ResourceGroupName "resource-group-name" -TemplateFile main.bicep'

The CLI will then prompt you for admin credentials for the VMs.
