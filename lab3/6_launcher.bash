#!/bin/bash


PRODUCER="./6_producer.bash"
HANDLER="./6_handler.bash"

$HANDLER &
cat | $PRODUCER &

wait -n
pkill -P $$

