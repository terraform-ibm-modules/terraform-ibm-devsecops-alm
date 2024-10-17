#!/bin/bash

function parse_input() {
  eval "$(jq -r '@sh "export EMAIL=\(.email) NAME=\(.name) APIKEY=\(.apikey) INSTANCE_ID=\(.instance_id) REGION=\(.region) SECRET_GROUP_ID=\(.secret_group_id) SIGNING_KEY_NAME=\(.signing_key_name) SIGNING_CERT_NAME=\(.signing_cert_name) ROTATE_SIGNING_KEY=\(.rotate_signing_key) ROTATE_SIGNING_CERT=\(.rotate_signing_cert)"')"
  if [[ -z "${EMAIL}" ]]; then export EMAIL=none; fi
  if [[ -z "${NAME}" ]]; then export NAME=none; fi
  if [[ -z "${APIKEY}" ]]; then export APIKEY=none; fi
  if [[ -z "${INSTANCE_ID}" ]]; then export INSTANCE_ID=none; fi
  if [[ -z "${REGION}" ]]; then export REGION=none; fi
  if [[ -z "${SECRET_GROUP_ID}" ]]; then export SECRET_GROUP_ID=none; fi
  if [[ -z "${SIGNING_KEY_NAME}" ]]; then export SIGNING_KEY_NAME=none; fi
  if [[ -z "${SIGNING_CERT_NAME}" ]]; then export SIGNING_CERT_NAME=none; fi
  if [[ -z "${ROTATE_SIGNING_KEY}" ]]; then export ROTATE_SIGNING_KEY=none; fi
  if [[ -z "${ROTATE_SIGNING_CERT}" ]]; then export ROTATE_SIGNING_CERT=none; fi
}

#login with the provided APIKEY and get the IAM bearer token
function getIAM_TOKEN() {

  ibmcloud login -apikey "$1" > /dev/null 2>&1

  IAM_ACCESS_TOKEN_FULL=$(curl -s -k -X POST \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --header "Accept: application/json" \
  --data-urlencode "grant_type=urn:ibm:params:oauth:grant-type:apikey" \
  --data-urlencode "apikey=${APIKEY}" \
  "https://iam.cloud.ibm.com/identity/token")

  local token
  token=$(echo "${IAM_ACCESS_TOKEN_FULL}" | \
    grep -Eo '"access_token":"[^"]+"' | \
    awk '{split($0,a,":"); print a[2]}' | \
    tr -d \")

  echo "${token}"
}

#get the metadata for the secrets in the specified secret group
function getSecretMetadata() {
  local iam_token=$1
  local base_url=$2
  local secret_group_id=$3
  local response
  response=$(curl -X GET --location --header "Authorization: Bearer ${iam_token}" --header "Accept: application/json" "${base_url}/api/v2/secrets?groups=${secret_group_id}")
  echo "${response}"
}

#extract the specific secret id from the provided metadata and return the secret payload
function getSecret() {
  local iam_token=$1
  local base_url=$2
  local secret_metadata=$3
  local keyname=$4
  local secret_id
  local response
  local payload
  secret_id=$(echo "${secret_metadata}" | jq -r --arg KEY_NAME "${keyname}" '.secrets[] | select(.name==$KEY_NAME) | .id')

  response=$(curl -X GET --location --header "Authorization: Bearer ${iam_token}" --header "Accept: application/json" "${base_url}/api/v2/secrets/${secret_id}")

  payload=$(echo "${response}" | jq -r '.payload')
  if [[ -z "${payload}" ]]  ||  [[ "${payload}" == "null" ]] || [[ "${payload}" == null ]]; then
    payload=""
  fi
  echo "${payload}"
}

function prepareKeyDetails {
  FILE="gpg_file.txt"
  touch "${FILE}"
    {
      echo "%echo Generating GPG key"
      echo "Key-Type: RSA"
      echo "Key-Length: 3072"
      echo "Subkey-Type: RSA"
      echo "Subkey-Length: 2048"
      echo "Key-Usage: cert, sign"
      echo "Subkey-Usage: encrypt"
      echo "Name-Real: ${NAME}"
      echo "Name-Email: ${EMAIL}"
      echo "Expire-Date: 2y"
      echo "%no-ask-passphrase"
      echo "%no-protection"
      echo "%commit"
      echo "%echo done"
    } >> "${FILE}"

    gpg --batch --gen-key "${FILE}"
    rm -rf "${FILE}"
}

function importKey {
  FILE="gpg_file.txt"
  touch "${FILE}"
    {
      echo "${SIGNING_KEY_SECRET}" | base64 -D
    } >> "${FILE}"

    gpg --import "${FILE}"
    rm -rf "${FILE}"
}

function rotate_signing_cert() {
  KEY_LIST=$(gpg --list-secret-keys)

  if [[ "${KEY_LIST}" != *"${EMAIL}"* ]]; then
    # shellcheck disable=SC2091
    $(importKey)
  fi

  #Export the public signing certifacate
  SIGNING_CERT_SECRET=$(gpg --armor --export "${EMAIL}" | base64 -w0)
  #Terraform requires a JSON response from a script
  JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY_SECRET" --arg public_key "$SIGNING_CERT_SECRET" '{signingkey: $signing_key, publickey: $public_key}' )

  #return response

  echo "${JSON_STRING_RESULT}"
}

function rotate_signing_key() {
  KEY_LIST=$(gpg --list-secret-keys)

  if [[ "${KEY_LIST}" != *"${EMAIL}"* ]]; then
    # shellcheck disable=SC2091
    $(prepareKeyDetails)
  fi


  #Export the signing key
  SIGNING_KEY_SECRET=$(gpg --export-secret-key "${EMAIL}" | base64 -w0)
  #Terraform requires a JSON response from a script
  JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY_SECRET" --arg public_key "$SIGNING_CERT_SECRET" '{signingkey: $signing_key, publickey: $public_key}' )

  #return response

  echo "${JSON_STRING_RESULT}"
}

function generate_keys() {
  KEY_LIST=$(gpg --list-secret-keys)

  if [[ "${KEY_LIST}" != *"${EMAIL}"* ]]; then
    # shellcheck disable=SC2091
    $(prepareKeyDetails)
  fi


  #Export the signing key
  SIGNING_KEY_SECRET=$(gpg --export-secret-key "${EMAIL}" | base64 -w0)
  #Export the public signing certifacate
  SIGNING_CERT_SECRET=$(gpg --armor --export "${EMAIL}" | base64 -w0)
  #Terraform requires a JSON response from a script
  JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY_SECRET" --arg public_key "$SIGNING_CERT_SECRET" '{signingkey: $signing_key, publickey: $public_key}' )

  #return response

  echo "${JSON_STRING_RESULT}"
}

parse_input


BASE_URL="https://${INSTANCE_ID}.${REGION}.secrets-manager.appdomain.cloud"

IAM_ACCESS_TOKEN=$(getIAM_TOKEN "${APIKEY}")
SECRET_METADATA=$(getSecretMetadata "${IAM_ACCESS_TOKEN}" "${BASE_URL}" "${SECRET_GROUP_ID}")
SIGNING_KEY_SECRET=$(getSecret "${IAM_ACCESS_TOKEN}" "${BASE_URL}" "${SECRET_METADATA}" "${SIGNING_KEY_NAME}")
SIGNING_CERT_SECRET=$(getSecret "${IAM_ACCESS_TOKEN}" "${BASE_URL}" "${SECRET_METADATA}" "${SIGNING_CERT_NAME}")

#simplify the boolean logic
if [[  "${ROTATE_SIGNING_KEY}" == true ]]  ||  [[ "${ROTATE_SIGNING_KEY}" == "true" ]]; then
  ROTATE_SIGNING_KEY="true"
fi
if [[  "${ROTATE_SIGNING_CERT}" == true ]]  ||  [[ "${ROTATE_SIGNING_CERT}" == "true" ]]; then
  ROTATE_SIGNING_CERT="true"
fi

if [[  -z "${SIGNING_KEY_SECRET}" ]]  ||  [[ "${SIGNING_KEY_SECRET}" == "" ]]; then
  generate_keys #create keys for signing and cert and return
else #have an existing cert
  if [[  "${ROTATE_SIGNING_KEY}" == "true" ]]  &&  [[ "${ROTATE_SIGNING_CERT}" == "true" ]]; then
    generate_keys
  elif [[  "${ROTATE_SIGNING_KEY}" == "true" ]]; then
    rotate_signing_key
  elif [[ "${ROTATE_SIGNING_CERT}" == "true" ]]; then
    rotate_signing_cert
  else
    #return existing values
    JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY_SECRET" --arg public_key "$SIGNING_CERT_SECRET" '{signingkey: $signing_key, publickey: $public_key}' )
    echo "${JSON_STRING_RESULT}"
  fi
fi
