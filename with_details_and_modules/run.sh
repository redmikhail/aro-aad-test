#!/bin/bash

MAIN_PLAN_FILE="main.tfplan"
DESTROY_PLAN_FILE="destroy.tfplan"
PLAN="plan"
APPLY="apply"
DESTROY="destroy"

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
      break
      ;;
    "Terraform Destroy")
      op="destroy"
      call_terraform_for_plan_or_apply $op
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
    rm -f $DESTROY_PLAN_FILE $MAIN_PLAN_FILE
  elif [ "$op" == "$DESTROY" -a -f "${DESTROY_PLAN_FILE}" ]; then
    printf "\n\n -> Running terraform $op command using the ($DESTROY_PLAN_FILE) file...\n"
    terraform apply $DESTROY_PLAN_FILE
    rm -f $DESTROY_PLAN_FILE $MAIN_PLAN_FILE
  else
    run_terraform "$op"
  fi
}


function run_terraform() {
  local op="$1"

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

  TMP_VAR=""
  local clientSecret="NOT_SET"
  read -p "Please enter clientSecret (default [$clientSecret]): " TMP_VAR
  clientSecret="${TMP_VAR:-$clientSecret}"

  local extraOptions=""

  if [ "$op" == "$PLAN" ]; then
    printf "\nPlan for 'Apply' or 'Destroy' \n"
    select answer in "Apply" "Destroy"; do
        case $answer in
            Apply)
              extraOptions="-out ${MAIN_PLAN_FILE}"   # to output the Apply plan
              break;;
            Destroy)
              extraOptions="-destroy -out ${DESTROY_PLAN_FILE}"   # to output the Destroy plan
              break;;
        esac
    done
  fi

    printf "\n   -> key ids/values used"
    for i in op aroResourceGroup aroClusterName location extraOptions
    do
      printf "\n     - $i=${!i}"
    done

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
    -var "resource_group_location=$location" \
    -var "aro_client_secret=\"$clientSecret\""
  set +x
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
