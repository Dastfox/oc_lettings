# Utilisez une image de base appropriée pour votre projet Django
FROM python:3.11

# Définition du répertoire de travail dans le conteneur
WORKDIR /Python-OC-Lettings-FR


# Copiez les fichiers de votre projet dans le conteneur
COPY . /Python-OC-Lettings-FR


# Installez les dépendances de votre projet
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt


# Exécutez les commandes supplémentaires nécessaires pour préparer votre application
# Par exemple, effectuez les migrations de la base de données, collectez les fichiers statiques, etc.

# Définissez les variables d'environnement nécessaires pour votre application
ENV DJANGO_SETTINGS_MODULE=oc_lettings_site.settings

# Exposez le port sur lequel votre application Django écoute
# EXPOSE $PORT

# Exécutez la commande pour lancer votre application Django
CMD python manage.py makemigrations && python manage.py migrate && gunicorn oc_lettings_site.wsgi:application --bind 0.0.0.0:$PORT
