-- name: CreateUser :one
INSERT INTO users (id, name, email, password_hash, api_key)
VALUES (sqlc.arg('id'),sqlc.arg('name'), sqlc.arg('email'), sqlc.arg('password_hash'), encode(sha256(random()::text::bytea), 'hex'))
RETURNING *;



-- name: GetUser :one
SELECT id, created_at, updated_at, name, email, deleted_at
FROM users
WHERE id = sqlc.arg('id');

-- name: GetUserByEmail :one
SELECT id, created_at, updated_at, name, email, deleted_at
FROM users
WHERE email = sqlc.arg('email');

-- name: GetUserByAPIKey :one
SELECT *
FROM users
WHERE api_key = sqlc.arg('api_key');


-- name: GetAllUsers :many
SELECT *
FROM users;


