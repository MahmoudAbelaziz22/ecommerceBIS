#!/bin/sh
rm -rf vendor composer.lock
composer install
php artisan key:generate

