FROM php:8.2-apache

RUN apt-get update && apt-get install -y git unzip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/html

FROM node:20

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

CMD ["npm", "start"]

FROM mcr.microsoft.com/dotnet/sdk:8.0

WORKDIR /app
COPY . .

RUN dotnet restore
RUN dotnet publish -c Release -o out

ENTRYPOINT ["dotnet", "out/app.dll"]

FROM python:3.11

WORKDIR /app

COPY . .

RUN pip install fastapi uvicorn psycopg2

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

FROM quay.io/wildfly/wildfly

COPY ./app.war /opt/jboss/wildfly/standalone/deployments/