#!/bin/bash -xe

php artisan key:generate
php artisan storage:link
php artisan config:cache
php artisan passport:install
composer dump-autoload
php artisan serve --host=0.0.0.0 --port=5000
