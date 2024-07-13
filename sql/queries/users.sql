-- name: CreateUser :one
INSERT INTO users (id, name, email, password_hash)
VALUES (sqlc.arg('id'),sqlc.arg('name'), sqlc.arg('email'), sqlc.arg('password_hash'))
RETURNING id, created_at, updated_at, name, email, password_hash, deleted_at;
