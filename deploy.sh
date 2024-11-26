#!/bin/bash

   # Установите нужные переменные
   REPO_URL="https://github.com/drumspb/shvirtd-example-python"
   PROJECT_DIR="/opt/my_project"

   # Клонировать репозиторий
   sudo git clone $REPO_URL $PROJECT_DIR

   # Перейти в каталог проекта
   cd $PROJECT_DIR

   # Запустить проект
   sudo docker-compose up -d