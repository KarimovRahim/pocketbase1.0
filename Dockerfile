FROM alpine:latest

ARG PB_VERSION=0.22.0

RUN apk add --no-cache unzip ca-certificates

ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

COPY ./pb_data /pb/pb_data

RUN chmod -R 777 /pb/pb_data

EXPOSE 8080

# Убираем лишние команды миграций, запускаем только сервер
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080", "--dir=/pb/pb_data"]
