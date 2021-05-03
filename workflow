Dashboard qui :
- Permet de visionner et gérer les services du cluster

Load Balancer qui :
- Est le SEUL point d'entrée vers le cluster
- Redirige toutes les requêtes vers le bon service (ports dédiés)
- Utiliser UNE seule adresse IP

Wordpress (port 5050) [type LoadBalancer] qui :
- Utilise une DB MySQL (container indépendant)
- Aura son propre serveur nginx
- Comporte plusieurs utilisateurs et un administrateur
- Contient un site fonctionnel et déjà paramétré

PHPMyAdmin (port 5000) [type LoadBalancer] qui:
- Doit être relié à la DB MySQL
- Aura son propre serveur nginx

Serveur Nginx (ports 80 et 443) [type LoadBalancer] qui:
- Devra rediriger systématiquement toutes les requêtes faites en HTTP sur le port 80 vers le port 443 (redirection type 301) qui sera en HTTPS
- Ne devra pas afficher d'erreur HTTP après redirection
- Devra permettre d'accéder à /wordpress (redirection type 307) vers IP :WPPORT
- Devra permettre d'accéder à /phpmyadmin (reverse proxy) vers IP :PMAPORT

Serveur FTPS (port 21) [type LoadBalancer]

Grafana (port 3000) [type LoadBalancer] qui :
- Fonctionne avec une DB InfluxDB (container indépendant)
- Permet de monitorer tous les containers
- Aura un dashboard par container

MySQL et InfluxDB [type ClusterIP] :
- Persistance des données dans un volume en cas de crash ou d'arrêt, même aprês suppression

TOUS :
- Les containers doivent redemarrer automatiquement en cas de crash ou d'arrêt
