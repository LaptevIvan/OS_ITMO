#!/bin/bash

PRODUCER="./5_producer.bash"
HANDLER="./5_handler.bash"

$HANDLER &
cat | $PRODUCER &

wait -n
pkill -P $$ 
