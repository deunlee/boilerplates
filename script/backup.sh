#!/bin/bash

DATE_TIME=$(date '+%y%m%d-%H%M%S');
BACKUP_DIR="./backup"
mkdir -p "$BACKUP_DIR"

TGZ_PATH="$BACKUP_DIR/full-$DATE_TIME.tgz"
SQL_PATH="$BACKUP_DIR/sql-$DATE_TIME.sql"
SQL_INIT="./service/mariadb/init/init-database.sql"

echo
echo ">>> Started full backup at $(date)."
echo
echo ">>> Full archive : $TGZ_PATH"
echo ">>> SQL only     : $SQL_PATH"
echo

docker-compose exec mariadb \
    sh -c 'exec mysqldump --databases "$MYSQL_DATABASE" -uroot -p"$MYSQL_ROOT_PASSWORD" --skip-extended-insert' \
    > "$SQL_PATH"

if [ $? -ne 0 ]; then
    rm "$SQL_PATH"
    echo ">>> Failed to dump database."
    echo ">>> Make sure the mariadb container is running."
    echo
    exit
fi

rm -f "$SQL_INIT"
cp "$SQL_PATH" "$SQL_INIT"

tar --exclude='./backup' \
    --exclude='./service/mariadb/database' \
    -cf "$TGZ_PATH" .
    # -zcf "$TGZ_PATH" .

echo ">>> Backup completed successfully at $(date)."
echo

ls "$BACKUP_DIR" -lh | grep "$DATE_TIME"
