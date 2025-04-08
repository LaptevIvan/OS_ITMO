#!/bin/bash

ps -ax | grep "/sbin/" | awk '{
	pid = $1
	print pid}' > 2_out

