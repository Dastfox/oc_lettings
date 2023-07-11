# Utilisez une image de base appropriée pour votre projet Django
FROM python:3.11

# Définition du répertoire de travail dans le conteneur
WORKDIR /Python-OC-Lettings-FR


# Copiez les fichiers de votre projet dans le conteneur
COPY . /Python-OC-Lettings-FR

# port d'écoute de l'application
ENV PORT=$PORT
# ensure that the python output is sent straight to terminal (avoid buffering)
ENV PYTHONUNBUFFERED=1
# avoid creating .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
# django secret key
ENV SECRET_KEY = $SECRET_KEY
# sentry dsn
ENV SENTRY_DSN = $SENTRY_DSN

# Installez les dépendances de votre projet
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

EXPOSE $PORT

CMD python manage.py collectstatic --no-input && python manage.py runserver 0.0.0.0:$PORT