FROM alpine:latest

# Возвращаем актуальную версию
ARG PB_VERSION=0.22.0

RUN apk add --no-cache unzip ca-certificates

# Скачиваем PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

# Копируем твои данные
COPY ./pb_data /pb/pb_data

# Даем права на папку
RUN chmod -R 777 /pb/pb_data

EXPOSE 8080

# Команда запуска с автоматическим обновлением миграций
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080", "--dir=/pb/pb_data", "migrations", "up", "&&", "/pb/pocketbase", "serve", "--http=0.0.0.0:8080", "--dir=/pb/pb_data"]

# Если верхняя команда покажется сложной, можно просто:
# CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]
