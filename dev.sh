#!/usr/bin/env bash

IMAGE="dev"

PORT_ARGS=()
NAME=""
ENVIRONMENT=""
RUN=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        -p)
            PORT_ARGS+=("-p" "127.0.0.1:$2:$2")
            shift 2
            ;;
        -n)
            NAME="$2"
            shift 2
            ;;
        -r)
            RUN=1
            shift 1
            ;;
        *)
            echo "Unknown argument: $1"
            exit 1
            ;;
    esac
done


if [[ "$RUN" -eq 1 ]]; then
    docker run \
        --name "$NAME" \
        -d -i -t \
        --mount type=bind,src=$PWD,dst=/home/billydocker/workspace \
        "${PORT_ARGS[@]}" \
        "$IMAGE"
    docker exec -it "$NAME" bash
else
    docker exec -it "$NAME" bash
fi
