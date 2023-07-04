# Utilisez une image de base appropriée pour votre projet Django
FROM python:3.11

# Définition du répertoire de travail dans le conteneur
WORKDIR /Python-OC-Lettings-FR


# Copiez les fichiers de votre projet dans le conteneur
COPY . /Python-OC-Lettings-FR

ENV PORT=8000
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV DJANGO_SETTINGS_MODULE=oc_lettings_site.settings

# Installez les dépendances de votre projet
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

EXPOSE $PORT

CMD python manage.py collectstatic --no-input && python manage.py runserver 0.0.0.0:$PORT