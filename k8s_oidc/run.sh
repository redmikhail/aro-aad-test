#!/bin/bash

MAIN_PLAN_FILE="main.tfplan"
DESTROY_PLAN_FILE="destroy.tfplan"
PLAN="plan"
APPLY="apply"
IMPORT="import"
DESTROY="destroy"


function display_menu_and_get_choice() {
  # Print the menu
  echo "================================================="
  echo "Choose an option: "
  echo "================================================="
  options=(
    "Terraform Init"
    "Terraform Plan"
    "Terraform Import"
    "Terraform Apply"
    "Terraform Destroy"
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
      op=$PLAN
      call_terraform_for_plan_or_apply $op
      break
      ;;
    "Terraform Import")
      op=$IMPORT
      call_terraform_for_plan_or_apply $op
      break
      ;;
    "Terraform Apply")
      op=$APPLY
      call_terraform_for_plan_or_apply $op
      break
      ;;
    "Terraform Destroy")
      op=$DESTROY
      call_terraform_for_plan_or_apply $op
      break
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
    set -x
    terraform apply $MAIN_PLAN_FILE
    set +x
    rm -f $DESTROY_PLAN_FILE $MAIN_PLAN_FILE
  elif [ "$op" == "$DESTROY" -a -f "${DESTROY_PLAN_FILE}" ]; then
    printf "\n\n -> Running terraform $op command using the ($DESTROY_PLAN_FILE) file...\n"
    set -x
    terraform apply $DESTROY_PLAN_FILE
    set +x
    rm -f $DESTROY_PLAN_FILE $MAIN_PLAN_FILE
  else
    run_terraform "$op"
  fi
}


function run_terraform() {
  local op="$1"
  local FILE_OPTION="file"

  local TMP_VAR=""
  local varFileOrPromptForVars=""
  while [[ "$varFileOrPromptForVars" != "${FILE_OPTION}" && "$varFileOrPromptForVars" != "prompt" ]]
  do
    read -p "For most of the variables, use file or prompt (file/prompt): " TMP_VAR
    varFileOrPromptForVars="${TMP_VAR:-$varFileOrPromptForVars}"
  done

  local extraOptions=""

  if [ "$varFileOrPromptForVars" == "file" ]; then
    extraOptions="-var-file=custom.tfvars"
  else
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
    local tenantId="NOT_SET"
    read -p "Please enter tenantId (default [$tenantId]): " TMP_VAR
    tenantId="${TMP_VAR:-$tenantId}"

    TMP_VAR=""
    local clientId="NOT_SET"
    read -p "Please enter clientId (default [$clientId]): " TMP_VAR
    clientId="${TMP_VAR:-$clientId}"

    TMP_VAR=""
    local clientSecret="NOT_SET"
    read -p "Please enter clientSecret (default [$clientSecret]): " TMP_VAR
    clientSecret="${TMP_VAR:-$clientSecret}"

    extraOptions="-var \"resource_group_name=$aroResourceGroup\""
    extraOptions="${extraOptions} -var \"cluster_name=$aroClusterName\""
    extraOptions="${extraOptions} -var \"region=$location\""
    extraOptions="${extraOptions} -var \"tenant_id=\"$tenantId\"\""
    extraOptions="${extraOptions} -var \"client_id=\"$clientId\"\""
    extraOptions="${extraOptions} -var \"client_secret=\"$clientSecret\"\""

    printf "\n   -> key ids/values used"
    for i in op aroResourceGroup aroClusterName location extraOptions
    do
      printf "\n     - $i=${!i}"
    done
  fi

  if [ "$op" == "$PLAN" ]; then
    printf "\nPlan for 'Apply' or 'Destroy' \n"
    select answer in "Apply" "Destroy"; do
        case $answer in
            Apply)
              extraOptions="-out ${MAIN_PLAN_FILE} ${extraOptions}"               # to output the Apply plan
              break;;
            Destroy)
              extraOptions="-destroy -out ${DESTROY_PLAN_FILE} ${extraOptions}"   # to output the Destroy plan
              break;;
        esac
    done
  elif [ "$op" == "$APPLY" -o "$op" == "$DESTROY"  ]; then
   extraOptions="-auto-approve ${extraOptions}"
  elif [ "$op" == "$IMPORT" ]; then
    extraOptions="${extraOptions} kubernetes_manifest.oidc apiVersion=config.openshift.io/v1,kind=OAuth,name=cluster"
  fi

  printf "\n\n -> Running terraform $op command...\n"

  set -x
  terraform $op -compact-warnings $extraOptions
  set +x
}


display_menu_and_get_choice
