-- +goose Up
ALTER TABLE feed ADD COLUMN last_fetched_at TIMESTAMP WITH TIME ZONE;


CREATE TRIGGER update_last_fetched_at_trigger
BEFORE UPDATE ON feed
FOR EACH ROW
EXECUTE FUNCTION update_updated_at('last_fetched_at');



CREATE TRIGGER update_updated_at_trigger
BEFORE UPDATE ON feed
FOR EACH ROW
EXECUTE FUNCTION update_updated_at('updated_at');

-- +goose Down
DROP TRIGGER IF EXISTS update_last_fetched_at_trigger ON feed;
DROP FUNCTION IF EXISTS update_last_fetched_at;
ALTER TABLE feed DROP COLUMN last_fetched_at;
