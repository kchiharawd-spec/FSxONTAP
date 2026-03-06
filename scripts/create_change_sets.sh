#!/bin/bash
set -e

if [ $# -ne 1 ]; then
    echo "$0 <ENV_TYPE(dev|stg|prod)>"
    exit 1
elif [ "$1" != "dev" ] && [ "$1" != "stg" ] && [ "$1" != "prod" ]; then
    echo "$0 <ENV_TYPE(dev|stg|prod)>"
    exit 1
fi

cd "$(dirname "$0")"

SYSTEM_NAME="fsx-lab"
ENV_TYPE=$1

create_change_set() {
    STACK_NAME=$1
    CHANGE_SET_NAME="${STACK_NAME}-create-$(date +%s)"

    aws cloudformation create-change-set \
        --stack-name "${SYSTEM_NAME}-${ENV_TYPE}-${STACK_NAME}" \
        --change-set-name "${CHANGE_SET_NAME}" \
        --change-set-type CREATE \
        --template-body "file://../cfn/${STACK_NAME}/${STACK_NAME}.yml" \
        --parameters "file://../cfn/${STACK_NAME}/${ENV_TYPE}-parameters.json"
}

create_change_set network
#create_change_set compute
#create_change_set storage

exit 0