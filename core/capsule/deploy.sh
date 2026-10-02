#!/usr/bin/env bash
set -euo pipefail

# Ідемпотентність: видаляємо старий контейнер, якщо він уже існував
docker rm -f devbox2 2>/dev/null || true

# Піднімаємо контейнер із прокиданням порту 8080 (Рівень 2)
docker run -dit -p 8080:80 --name devbox2 ubuntu:24.04 bash

# Встановлюємо необхідні утиліти всередині контейнера (Рівень 3)
docker exec devbox2 apt-get update
docker exec devbox2 apt-get install -y python3 curl git procps iproute2

# Запускаємо простий HTTP-сервер у фоновому режимі
docker exec -d devbox2 python3 -m http.server 80

echo "Успіх! Контейнер запущено, порт 8080 прокинуто."
echo "Перевірити можна командою: curl -i http://localhost:8080/"