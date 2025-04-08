#!/bin/bash


PRODUCER="./Mod_producer.bash"
HANDLER="./Mod_handler.bash"

$HANDLER &
cat | $PRODUCER &

wait -n
pkill -P $$


