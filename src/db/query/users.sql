-- name: CreateUser :one
INSERT INTO users (id, first_name, last_name, email, phone_number)
VALUES ($1, $2, $3, $4, $5)
RETURNING *;

-- name: UpdateUser :one
UPDATE users
SET
    first_name = COALESCE(NULLIF($2::text, ''::text), first_name),
    last_name = COALESCE(NULLIF($3::text, ''::text), last_name),
    email = COALESCE(NULLIF($4::text, ''::text), email)
WHERE
    id = $1
RETURNING
    *;

-- name: DeleteUser :exec
DELETE FROM users WHERE id = $1;

-- name: GetUser :one
SELECT * FROM users WHERE id = $1;

-- name: GetUsers :many
SELECT * FROM users ORDER BY created_at LIMIT $1 OFFSET $2;