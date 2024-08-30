package db

import (
	"context"
	"log"
	"os"
	"testing"

	
	"github.com/jackc/pgx/v5/pgxpool"
	_ "github.com/jackc/pgx/v5/stdlib"
)

// setup a testQueries (similar to the queries in store.go generated by sqlc) and a database pool for testing only
var testQueries *Queries
var pool *pgxpool.Pool

// this is the entry point for all tests, just like server.go
func TestMain(m *testing.M) {
	var err error

	config := util.Config{
		DBSource:            `postgres://omala:password@localhost:5432/omala?sslmode=disable&connect_timeout=5`,
		MigrationURL:        "file://src/db/migration",
		ServerAddress:       "0.0.0.0:8080",
		Domain:              "localhost",
	}

	pool, err = pgxpool.New(context.Background(), config.DBSource)
	if err != nil {
		log.Fatal("Error connecting to database: ", err)
	}

	testQueries = New(pool)

	defer pool.Close() // Close the pool after tests

	os.Exit(m.Run())
}