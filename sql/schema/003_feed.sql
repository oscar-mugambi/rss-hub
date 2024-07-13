-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied



-- Create the feed table
CREATE TABLE feed (
  id UUID PRIMARY KEY,
  name TEXT NOT NULL,
  url TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (NOW() AT TIME ZONE 'UTC'),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (NOW() AT TIME ZONE 'UTC'),
  deleted_at TIMESTAMP WITH TIME ZONE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

-- Create a trigger to automatically update the updated_at column
CREATE TRIGGER update_feed_updated_at
BEFORE UPDATE ON feed
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TRIGGER IF EXISTS update_feed_updated_at ON feed;
DROP FUNCTION IF EXISTS update_updated_at();
DROP TABLE IF EXISTS feed;