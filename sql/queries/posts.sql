-- name: CreatePost :one
INSERT INTO posts (id, title, description, published_at,  url, feed_id)
VALUES (sqlc.arg('id'), sqlc.arg('title'), sqlc.arg('description'),  sqlc.arg('published_at') ,sqlc.arg('url'), sqlc.arg('feed_id'))
RETURNING *;

-- name: GetPosts :many
SELECT *
FROM posts;


-- name: GetPostsForUser :many

SELECT posts.* 
FROM posts
JOIN feed_follows ON feed_follows.feed_id = posts.feed_id
WHERE feed_follows.user_id = sqlc.arg('user_id')
ORDER BY posts.published_at DESC
LIMIT sqlc.arg('limit');