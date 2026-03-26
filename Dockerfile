FROM debian:bookworm-slim

# Устанавливаем нужные инструменты через apt (стабильнее в Railway)
RUN apt-get update && apt-get install -y \
    unzip \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Скачиваем версию 0.21.11 (она точно откроет твой data.db)
ADD https://github.com/pocketbase/pocketbase/releases/download/v0.21.11/pocketbase_0.21.11_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

# Копируем твою базу данных 9-Б
COPY ./pb_data /pb/pb_data

# Даем права доступа
RUN chmod -R 777 /pb/pb_data

EXPOSE 8080

# Запускаем сервер
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080", "--dir=/pb/pb_data"]
