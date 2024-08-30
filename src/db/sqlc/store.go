package db

import (
	"github.com/jackc/pgx/v5/pgxpool"
)

//go:generate sqlc generate
//go:generate mockgen -source store.go -destination mock/store_mock.go -package mock

type Store interface {
	Querier
	// TransferTx(ctx context.Context, arg TransferTxRequest) (TransfersTxResponse, error)
}

type SQLStore struct {
	*Queries
	pool *pgxpool.Pool
}

func NewStore(pool *pgxpool.Pool) Store {
	return &SQLStore{
		pool:    pool,
		Queries: New(pool),
	}
}
