#!/bin/bash

MAIN_PLAN_FILE="main.tfplan"
PLAN="plan"
APPLY="apply"

function fetch_details() {
  local TMP_VAR=""
  local resourcePrefix="test001"
  read -p "Please enter resource prefix (default [$resourcePrefix]): " TMP_VAR
  resourcePrefix="${TMP_VAR:-$resourcePrefix}"

  local TMP_VAR=""
  local aroResourceGroup="${resourcePrefix}RG"
  read -p "Please enter ARO resource group (default [$aroResourceGroup]): " TMP_VAR
  aroResourceGroup="${TMP_VAR:-$aroResourceGroup}"

  TMP_VAR=""
  local aroClusterName="${resourcePrefix}Aro"
  read -p "Please enter ARO cluster name (default [$aroClusterName]): " TMP_VAR
  aroClusterName="${TMP_VAR:-$aroClusterName}"

  TMP_VAR=""
  local location="canadacentral"
  read -p "Please enter location (default [$location]): " TMP_VAR
  location="${TMP_VAR:-$location}"

  local extraOptions="-out ${MAIN_PLAN_FILE}"

  printf "\n   -> key ids/values used"
  for i in op aroResourceGroup location extraOptions
  do
    printf "\n     - $i=${!i}"
  done

  local op="$PLAN"
  printf "\n\n -> Running terraform $op command...\n"
  extraOptions="-out ${MAIN_PLAN_FILE}"

  # if [ "$op" == "$PLAN" ]; then
    # extraOptions="-out ${MAIN_PLAN_FILE}"
  # else
  #   extraOptions="-auto-approve"
  # fi

  set -x
  terraform $op \
    -compact-warnings \
    $extraOptions \
    -var "aro_resource_group_name=$aroResourceGroup" \
    -var "aro_cluster_name=$aroClusterName" \
    -var "resource_group_location=$location"
  set +x

}


function confirm_login() {
  printf "\nAre you already logged in using az login? \n"
  select answer in "Yes" "No"; do
      case $answer in
          Yes) 
            echo ""
            fetch_details
            break;;
          No)
            echo "Please login first"
            exit 1;;
      esac
  done
}


confirm_login
