-- +goose Up
-- +goose StatementBegin
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    if TG_ARGV[0] IS NOT NULL AND TG_ARGV[0] = 'last_fetched_at' THEN
        NEW.last_fetched_at = (NOW() AT TIME ZONE 'UTC');
    END IF;

    if TG_ARGV[0] IS NOT NULL AND TG_ARGV[0] = 'updated_at' THEN
        NEW.updated_at = (NOW() AT TIME ZONE 'UTC');
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- +goose StatementEnd

-- +goose Down
-- Drop the function
DROP FUNCTION IF EXISTS update_updated_at();