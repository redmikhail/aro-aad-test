#!/bin/bash

MAIN_PLAN_FILE="main.tfplan"
PLAN="plan"
APPLY="apply"

function display_menu_and_get_choice() {
  # Print the menu
  echo "================================================="
  echo "WIP. Choose an option: "
  echo "================================================="
  options=(
    "Terraform Init"
    "Terraform Plan"
    "Terraform Apply"
    "Terraform Destroy"
    "Delete Resource Group"
    "Quit"
  )

  # Select an option
  COLUMNS=0
  select opt in "${options[@]}"; do
    case $opt in
    "Terraform Init")
      terraform init
      exit
      ;;
    "Terraform Plan")
      op="plan"
      call_terraform_for_plan_or_apply $op
      break
      ;;
    "Terraform Apply")
      op="apply"
      call_terraform_for_plan_or_apply $op
#      printf "\n -> WIP - NOT YET COMPLETE...\n"
      break
      ;;
    "Terraform Destroy")
      op="destroy"
#      call_terraform_for_plan_or_apply $op
      printf "\n -> WIP - NOT YET COMPLETE...\n"
      break
      ;;
    "Delete Resource Group")
      printf "\n -> WIP - NOT YET COMPLETE...\n"
#      delete_resource_group
      exit
      ;;
    "Quit")
      exit
      ;;
    *) echo "Invalid option $REPLY" ;;
    esac
  done
}


function call_terraform_for_plan_or_apply() {
  local op="$1"

  if [ "$op" == "$APPLY" -a -f "${MAIN_PLAN_FILE}" ]; then
    printf "\n\n -> Running terraform $op command using the ($MAIN_PLAN_FILE) file...\n"
    terraform apply $MAIN_PLAN_FILE
    rm -f $MAIN_PLAN_FILE
  else
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
  fi
}


function confirm_login() {
  printf "\nAre you already logged in using az login? \n"
  select answer in "Yes" "No"; do
      case $answer in
          Yes) 
            echo ""
            display_menu_and_get_choice
            break;;
          No)
            echo "Please login first"
            exit 1;;
      esac
  done
}


confirm_login
