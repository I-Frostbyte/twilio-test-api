DB_URL=postgres://twilio-example-user:twilio-example-password@localhost:5435/twilio-test-example-db?sslmode=disable&connect_timeout=5

install-tools: install-docker install-go install-migrate install-sqlc install-mockgen install-golangci-lint

run:
	go run github.com/githubnemo/CompileDaemon --build='go build ./cmd/api/...' --command='./api'

runpostgres:
	docker run --name twilio-test-example -p 5435:5432 -e POSTGRES_USER=twilio-example-user -e POSTGRES_PASSWORD=twilio-example-password -e POSTGRES_DB=twilio-test-example-db -d postgres:16-alpine

createdb:
	docker exec -it twilio-test-example createdb --username=twilio-example-user --owner=twilio-example-user twilio-test-example-db

dropdb:
	docker exec -it twilio-test-example dropdb --username=twilio-example-user twilio-test-example-db

migrateup:
	migrate -path src/db/migration -database "$(DB_URL)" -verbose up

migratedown:
	migrate -path src/db/migration -database "$(DB_URL)" -verbose down

generate:
	go generate ./...

create-migrate:
	migrate create -ext sql -dir ./src/db/migration -seq init_schema

.PHONY: install-docker
install-docker:
	@echo "Checking if Docker is installed..."
	@if command -v docker > /dev/null 2>&1; then \
		echo "Docker is already installed."; \
	else \
		echo "Docker is not installed. Please install docker before continuing"; \
		exit 1; \
	fi

.PHONY: install-go
install-go:
	@echo "Checking if Go is installed..."
	@if command -v go > /dev/null 2>&1; then \
		echo "Go is already installed."; \
		exit 0; \
	else \
		@echo "Go is not installed. Please install Go before continuing"; \
	fi

.PHONY: install-migrate
install-migrate:
	@echo "Installing migrate..."
	go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@v4.17.1

.PHONY: install-sqlc
install-sqlc:
	@echo "Installing sqlc..."
	go install github.com/sqlc-dev/sqlc/cmd/sqlc@v1.26.0

.PHONY: install-mockgen
install-mockgen:
	go install go.uber.org/mock/mockgen@latest

install-golangci-lint:
	@echo "Installing golangci-lint..."
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.55.0