#!/bin/bash

# current_dir=$(pwd)
# script_dir=$(dirname "$0")
# echo $current_dir
# echo $script_dir

confirm()
{
    # $1 for prompt string, $2 for default answer
    prompt="${1:-Are you sure?} "
    case $2 in
        [Yy]) prompt="$prompt[Y/n] " ;;
        [Nn]) prompt="$prompt[y/N] " ;;
        *)    prompt="$prompt[y/n] " ;;
    esac
    while true; do
        read -r -p "$prompt" response
        case $response in
            [Yy]|[Yy][Ee][Ss]) echo 'y'; break ;;
            [Nn]|[Nn][Oo])     echo 'n'; break ;;
            "") 
                case $2 in
                    [Yy]) echo 'y'; break ;;
                    [Nn]) echo 'n'; break ;;
                esac ;;
        esac
    done
}


ASSET_PATH="./asset"
mkdir -p "$ASSET_PATH"

BACKUP_PATH="./backup"

LOG_PATH="./log"
mkdir -p "$LOG_PATH/nginx"
mkdir -p "$LOG_PATH/php"

SERVICE_PATH="./service"
mkdir -p "$SERVICE_PATH/mariadb/database"
mkdir -p "$SERVICE_PATH/mariadb/init"


create_default_cert()
{
    CERT_PATH="./service/nginx/private"
    CERT_FILE="$CERT_PATH/default.crt"
    CERT_KEY="$CERT_PATH/default.key"
    mkdir -p "$CERT_PATH"
    if [ ! -e "$CERT_FILE" ] || [ ! -e "$CERT_KEY" ]; then
        openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
            -subj   "/C=US/ST=Test/L=Test/O=Test/CN=test.com" \
            -keyout "$CERT_KEY" \
            -out    "$CERT_FILE"
        echo "### Created a default certificate for nginx."
        # openssl x509 -text -noout -in "$CERT_FILE"
        chmod 600 "$CERT_KEY"
        chmod 600 "$CERT_FILE"
    fi
}



install_php_my_admin()
{
    PMA_URL="https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.zip"
    PMA_FILE="$ASSET_PATH/${PMA_URL##*/}"
    PMA_DIR="${PMA_FILE%.zip}"
    PMA_PATH="./www/html/pma"
    # Confirm reinstallation if already installed.
    if [ -d "$PMA_PATH" ]; then
        if [ $(confirm "### It's already installed. Do you want to reinstall?" "n") = "n" ]; then
            return 0
        fi
    fi
    # Download phpMyAdmin.
    if [ ! -e "$PMA_FILE" ]; then
        wget "$PMA_URL" -O "$PMA_FILE"
    fi
    # Unzip and move it.
    rm -rf "$PMA_DIR"
    rm -rf "$PMA_PATH"
    unzip -q "$PMA_FILE" -d "$ASSET_PATH"
    mv "$PMA_DIR" "$PMA_PATH"
    # Update the config file.
    RANDOM_SECRET=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32 ; echo '')
    cp "$PMA_PATH/config.sample.inc.php" "$PMA_PATH/config.inc.php"
    sed -i -e "s/cfg\['blowfish_secret'\] = ''/cfg['blowfish_secret'] = '$RANDOM_SECRET'/" "$PMA_PATH/config.inc.php"
    sed -i -e "s/\['host'\] = 'localhost'/\['host'\] = 'mariadb'/" "$PMA_PATH/config.inc.php"
    # Create temporary directory.
    mkdir "$PMA_PATH/tmp"
    chmod 777 "$PMA_PATH/tmp"
}

install_wordpress()
{
    # TODO
    return 0
}


create_default_cert

if [ $(confirm "### Do you want to install phpMyAdmin?" "y") = "y" ]; then
    install_php_my_admin
fi
