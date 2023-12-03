#!/bin/bash

while true; do
    nice -n 10 php /usr/src/artisan health:check
    sleep 60
done
