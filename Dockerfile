# syntax=docker/dockerfile:1

FROM python:3.10-alpine

WORKDIR /flask

RUN sed -i 's/https/http/' /etc/apk/repositories
RUN apk update && apk add --no-cache build-base
COPY requirement.txt requirement.txt
RUN pip3 install -r requirement.txt

RUN pwd
RUN ls -a
EXPOSE 5000

COPY . .
RUN python -m flask --app board init-db
CMD ["python", "-m", "flask", "--app", "board", "run", "--host=0.0.0.0", "--debug"]