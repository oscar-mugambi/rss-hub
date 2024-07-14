-- name: CreateFeed :one
INSERT INTO feed (id, name, url, user_id)
VALUES (sqlc.arg('id'), sqlc.arg('name'), sqlc.arg('url'), sqlc.arg('user_id'))
RETURNING *;


-- name: GetFeeds :many
SELECT *
FROM feed;


-- name: GetNextFeedsToFetch :many
SELECT * from feed
ORDER BY last_fetched_at ASC NULLS FIRST
LIMIT $1;

