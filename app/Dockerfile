FROM golang:1.25.5-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/app .

EXPOSE 8084

CMD [ "./app" ]

