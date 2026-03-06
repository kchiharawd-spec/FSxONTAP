#!/bin/bash
set -e

cd `dirname $0`

SYSTEM_NAME=cfn
ENV_TYPE=$1

delete_stack () {
    STACK_NAME=$1

    aws cloudformation delete-stack \
    --stack-name ${SYSTEM_NAME}-${ENV_TYPE}-${STACK_NAME}

    aws cloudformation wait stack-delete-complete \
    --stack-name ${SYSTEM_NAME}-${ENV_TYPE}-${STACK_NAME}
}

delete_stack storage
delete_stack compute
delete_stack network

exit 0