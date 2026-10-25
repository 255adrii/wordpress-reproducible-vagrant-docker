#!/bin/sh
set -e
cd /var/www/html

echo "Esperando a que WordPress copie sus ficheros..."
until [ -f wp-config.php ]; do sleep 2; done

echo "Esperando a la base de datos..."
until wp db check >/dev/null 2>&1; do sleep 3; done

if wp core is-installed >/dev/null 2>&1; then
  echo "WordPress ya estaba instalado."
else
  wp core install \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email
fi

wp theme activate webfusion
echo "Instalación completada: $WP_URL"
