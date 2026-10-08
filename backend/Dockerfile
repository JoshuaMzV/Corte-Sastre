FROM golang:1.22-alpine AS builder

WORKDIR /app
COPY go.mod ./
COPY main.go ./
RUN go mod tidy && CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o backend-api main.go

FROM alpine:3.20
RUN adduser -D -u 1001 -g '' appuser
WORKDIR /home/appuser
COPY --from=builder /app/backend-api .
COPY frontend ./frontend
USER appuser
EXPOSE 8088
ENTRYPOINT ["./backend-api"]
