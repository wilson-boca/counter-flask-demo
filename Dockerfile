# Dockerfile
FROM python:3.7-slim-buster
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential

ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update \
	&& apt-get install -y --no-install-recommends openssh-server \
	&& echo "$SSH_PASSWD" | chpasswd
COPY sshd_config /etc/ssh/

WORKDIR /app
COPY ./requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . /app
RUN chmod u+x /app/init.sh

ENV PORT 8000
ENV HOST 0.0.0.0
ENV FLASK_ENV=development
ENV DEBUG=True

EXPOSE 8000 2222

ENTRYPOINT ["/app/init.sh"]
#CMD exec gunicorn --bind $HOST:$PORT --workers 1 --threads 8 app:app