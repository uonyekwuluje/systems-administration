#!/bin/bash
# This script cleans all the resources in a given Azure Subscription. 
# Requirements:
# [1] A valid azure subscription
# [2] Elevated permissions and privilleges
# Usage: bash azure-resource-cleanup.sh <subscription id> 
SUBSCRIPTION_ID=$1

clean_resources() {
  get_azure_resource_groups=$(az group list --subscription ${SUBSCRIPTION_ID} -o table | awk '{print $1}' | awk 'NR > 2')
  for rg in ${get_azure_resource_groups[@]}
  do
    echo "Deleting Resource Group :=> ${rg}"
    az group delete --name ${rg} --subscription ${SUBSCRIPTION_ID} --verbose -y
    echo ""
  done
}


clean_resources
