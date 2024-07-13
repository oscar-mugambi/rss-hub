-- +goose Up
CREATE TABLE users (
  id UUID PRIMARY KEY,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
  name VARCHAR(100) NOT NULL CHECK (LENGTH(TRIM(name)) > 0),
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  deleted_at TIMESTAMP WITH TIME ZONE
);

CREATE INDEX idx_users_name ON users(name);
CREATE INDEX idx_users_email ON users(email);

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- +goose StatementEnd

CREATE TRIGGER set_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- +goose Down
DROP TRIGGER IF EXISTS set_updated_at ON users;
DROP FUNCTION IF EXISTS trigger_set_timestamp();
DROP INDEX IF EXISTS idx_users_name;
DROP INDEX IF EXISTS idx_users_email;
DROP TABLE IF EXISTS users;