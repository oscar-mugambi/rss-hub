-- +goose Up
CREATE TABLE posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (NOW() AT TIME ZONE 'UTC'),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (NOW() AT TIME ZONE 'UTC'),
  description TEXT,
  published_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (NOW() AT TIME ZONE 'UTC'),
  url TEXT NOT NULL UNIQUE,
  feed_id UUID NOT NULL REFERENCES feed(id) ON DELETE CASCADE
);

CREATE TRIGGER update_updated_at_trigger
BEFORE UPDATE ON posts
FOR EACH ROW
EXECUTE FUNCTION update_updated_at('updated_at');


-- +goose Down
DROP TRIGGER IF EXISTS update_updated_at_trigger ON posts;
DROP TABLE IF EXISTS posts;