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

delete_stack() {
    STACK_NAME=$1

    aws cloudformation delete-stack \
        --stack-name "${SYSTEM_NAME}-${ENV_TYPE}-${STACK_NAME}"

    aws cloudformation wait stack-delete-complete \
        --stack-name "${SYSTEM_NAME}-${ENV_TYPE}-${STACK_NAME}"
}

#delete_stack storage
delete_stack compute
delete_stack network

exit 0