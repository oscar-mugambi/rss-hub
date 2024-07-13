-- name: CreateFeed :one
INSERT INTO feed (id, name, url, user_id)
VALUES (sqlc.arg('id'), sqlc.arg('name'), sqlc.arg('url'), sqlc.arg('user_id'))
RETURNING *;


-- name: GetFeeds :many
SELECT *
FROM feed;

-- -- name: GetFeed :one
-- SELECT id, created_at, updated_at, name, url, deleted_at, user_id
-- FROM feed
-- WHERE id = sqlc.arg('id');

-- -- name: GetFeedByUser :many
-- SELECT id, created_at, updated_at, name, url, deleted_at, user_id
-- FROM feed
-- WHERE user_id = sqlc.arg('user_id');