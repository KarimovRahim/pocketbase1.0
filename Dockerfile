FROM alpine:latest

# Устанавливаем зависимости с обновлением репозиториев
RUN apk update && apk add --no-cache unzip ca-certificates

# Скачиваем версию 0.21.11
ADD https://github.com/pocketbase/pocketbase/releases/download/v0.21.11/pocketbase_0.21.11_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

# Копируем твои данные 9-Б
COPY ./pb_data /pb/pb_data

# Права доступа
RUN chmod -R 777 /pb/pb_data

EXPOSE 8080

CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080", "--dir=/pb/pb_data"]
