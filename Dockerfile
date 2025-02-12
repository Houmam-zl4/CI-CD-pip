# Utilisation de l'image nginx alpine comme base
FROM nginx:alpine

# Installation de Node.js et npm
RUN apk add --no-cache nodejs npm

# Copier le fichier index.html dans le conteneur

COPY CI-CD-pip/index.html /usr/share/nginx/html/index.html
