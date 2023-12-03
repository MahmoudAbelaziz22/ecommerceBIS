#!/bin/bash

nice -10 php /usr/src/artisan optimize && php /usr/src/artisan queue:work --queue=default,notification --tries=3 --verbose --timeout=30 --sleep=3 --max-jobs=1000 --max-time=3600
