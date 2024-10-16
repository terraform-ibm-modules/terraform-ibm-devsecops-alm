#!/bin/bash

#dnf install pinentry -y

function parse_input() {
  eval "$(jq -r '@sh "export EMAIL=\(.email) NAME=\(.name) SIGNING_CERT=\(.signing_cert) SIGNING_KEY=\(.signing_key) ROTATE_SIGNING_KEY=\(.rotate_signing_key) ROTATE_SIGNING_CERT=\(.rotate_signing_cert)"')"
  if [[ -z "${EMAIL}" ]]; then export EMAIL=none; fi
  if [[ -z "${NAME}" ]]; then export NAME=none; fi
  if [[ -z "${SIGNING_CERT}" ]]; then export SIGNING_CERT=none; fi
  if [[ -z "${SIGNING_KEY}" ]]; then export SIGNING_KEY=none; fi
  if [[ -z "${ROTATE_SIGNING_KEY}" ]]; then export ROTATE_SIGNING_KEY=none; fi
  if [[ -z "${ROTATE_SIGNING_CERT}" ]]; then export ROTATE_SIGNING_CERT=none; fi
}

#simplify the boolean logic
if [[  "${ROTATE_SIGNING_KEY}" == true ]]  ||  [[ "${ROTATE_SIGNING_KEY}" == "true" ]]; then
  ROTATE_SIGNING_KEY="true"
fi
if [[  "${ROTATE_SIGNING_CERT}" == true ]]  ||  [[ "${ROTATE_SIGNING_CERT}" == "true" ]]; then
  ROTATE_SIGNING_CERT="true"
fi

function createKey {
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
      echo "${SIGNING_KEY}" | base64 -D
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
  #SIGNING_CERT=$(gpg --armor --export "${EMAIL}" | base64 -w0)
  SIGNING_CERT=$(gpg --armor --export "${EMAIL}" | base64)
  #Terraform requires a JSON response from a script
  JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY" --arg public_key "$SIGNING_CERT" '{signingkey: $signing_key, publickey: $public_key}' )

  #return response

  echo "${JSON_STRING_RESULT}"
}

function rotate_signing_key() {
  KEY_LIST=$(gpg --list-secret-keys)

  if [[ "${KEY_LIST}" != *"${EMAIL}"* ]]; then
    # shellcheck disable=SC2091
    $(createKey)
  fi


  #Export the signing key
  #SIGNING_KEY=$(gpg --export-secret-key "${EMAIL}" | base64 -w0)
  SIGNING_KEY=$(gpg --export-secret-key "${EMAIL}" | base64)
  #Terraform requires a JSON response from a script
  JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY" --arg public_key "$SIGNING_CERT" '{signingkey: $signing_key, publickey: $public_key}' )

  #return response

  echo "${JSON_STRING_RESULT}"
}

function generate_keys() {
  KEY_LIST=$(gpg --list-secret-keys)

  if [[ "${KEY_LIST}" != *"${EMAIL}"* ]]; then
    # shellcheck disable=SC2091
    $(createKey)
  fi


  #Export the signing key
  #SIGNING_KEY=$(gpg --export-secret-key "${EMAIL}" | base64 -w0)
  SIGNING_KEY=$(gpg --export-secret-key "${EMAIL}" | base64)
  #Export the public signing certifacate
  #SIGNING_CERT=$(gpg --armor --export "${EMAIL}" | base64 -w0)
  SIGNING_CERT=$(gpg --armor --export "${EMAIL}" | base64)
  #Terraform requires a JSON response from a script
  JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY" --arg public_key "$SIGNING_CERT" '{signingkey: $signing_key, publickey: $public_key}' )

  #return response

  echo "${JSON_STRING_RESULT}"
}

parse_input



if [[  -z "${SIGNING_KEY}" ]]  ||  [[ "${SIGNING_KEY}" == "" ]]; then
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
    JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY" --arg public_key "$SIGNING_CERT" '{signingkey: $signing_key, publickey: $public_key}' )
  fi
fi
