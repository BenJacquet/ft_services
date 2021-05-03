# Installation de packages necessaires
apk update
apk add nginx openssl openssh openrc vim

# Setup de ssl et génération du certificat
mkdir /etc/nginx/ssl
chmod 700 /etc/nginx/ssl
openssl req -x509 -config ssl_request.conf -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt

# Installation de la config nginx et de l'index
# mv nginx.conf /etc/nginx/
mv index.html /var/www
mv nginx.conf etc/nginx
mv default.conf etc/nginx/conf.d

# Generation de la clé ssh avec tous les champs par défaut
ssh-keygen -A

# Changement du dossier run qui n'existe pas au bon endroit par défaut sur Alpine Linux et rafraichissement de nginx
nginx -g "pid /run/nginx/nginx.pid;"
nginx -s reload