#!/bin/bash

ps -axo pid --sort=start | tail -n 4 | sed -n 1p

