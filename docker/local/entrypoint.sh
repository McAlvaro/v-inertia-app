#!/usr/bin/env sh
set -e

# logging functions
in_log() {
        local type="$1"; shift
        printf '%s [%s] [Entrypoint]: %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$type" "$*"
}

in_error() {
        in_log ERROR "$@" >&2
        exit 1
}

# Indirect expansion (ie) is not supported in bourne shell. That's why we are using this "magic" here.
ie_gv() {
        eval "echo \$$1"
}

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
        local var="$1"
        local fileVar="${var}_FILE"
        local def="${2:-}"

        if [ "$(ie_gv ${var})" != ""  ] && [ "$(ie_gv ${fileVar})" != "" ]; then
                in_error "Both $var and $fileVar are set (but are exclusive)"
        fi

        local val="$def"
        if [ "$(ie_gv ${var})" != "" ]; then
                val=$(ie_gv ${var})
        elif [ "$(ie_gv ${fileVar})" != "" ]; then
                val=`cat $(ie_gv ${fileVar})`
        fi

        export "$var"="$val"
        unset "$fileVar"
}

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi
# Initialize values that might be stored in a file
file_env 'APP_KEY'
file_env 'DB_HOST'
file_env 'DB_PORT'
file_env 'DB_DATABASE'
file_env 'DB_USERNAME'
file_env 'DB_USERNAME'
file_env 'DB_PASSWORD'

# Run Laravel stuff

php artisan config:cache
php artisan migrate --force
php artisan db:seed --force

exec docker-php-entrypoint "$@"