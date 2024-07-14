-- +goose Up

-- Create the feed_follows table with inline constraints
CREATE TABLE feed_follows (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (NOW() AT TIME ZONE 'UTC'),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (NOW() AT TIME ZONE 'UTC'),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  feed_id UUID NOT NULL REFERENCES feed(id) ON DELETE CASCADE,
  UNIQUE (user_id, feed_id)
);

-- +goose StatementBegin
CREATE TRIGGER update_feed_follows_updated_at
BEFORE UPDATE ON feed_follows
FOR EACH ROW
EXECUTE FUNCTION update_updated_at('updated_at');
-- +goose StatementEnd

-- Create indexes for better query performance
CREATE INDEX idx_feed_follows_user_id ON feed_follows(user_id);
CREATE INDEX idx_feed_follows_feed_id ON feed_follows(feed_id);

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TRIGGER IF EXISTS update_feed_follows_updated_at ON feed_follows;
DROP INDEX IF EXISTS idx_feed_follows_user_id;
DROP INDEX IF EXISTS idx_feed_follows_feed_id;
DROP TABLE IF EXISTS feed_follows;