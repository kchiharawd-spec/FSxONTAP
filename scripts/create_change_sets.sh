#!/bin/bash
set -e

if [ $# -ne 1 ]; then
    echo "$0 <ENV_TYPE(dev|stg|prod)>"
    exit 1
fi

cd `dirname $0`

SYSTEM_NAME=cfn
ENV_TYPE=$1

create_change_set () {
    STACK_NAME=$1

    aws cloudformation create-change-set \
    --stack-name ${SYSTEM_NAME}-${ENV_TYPE}-${STACK_NAME} \
    --change-set-name ${STACK_NAME}-changeset \
    --template-body file://../${SYSTEM_NAME}/${STACK_NAME}/${STACK_NAME}.yml \
    --parameters file://../${SYSTEM_NAME}/${STACK_NAME}/${ENV_TYPE}-parameters.json \
    --capabilities CAPABILITY_NAMED_IAM
}

create_change_set network
create_change_set compute
create_change_set storage

exit 0