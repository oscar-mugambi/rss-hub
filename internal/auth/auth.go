package auth

import (
	"errors"
	"net/http"
	"strings"
)

func GetApiKey(headers http.Header) (string, error) {
	apiKey := headers.Get("Authorization")
	if apiKey == "" {
		return "", errors.New("authorization header not found")
	}

	val := strings.Split(apiKey, " ")
	if len(val) != 2 {
		return "", errors.New("invalid Authorization header")
	}

	if val[0] != "Bearer" {
		return "", errors.New("invalid Authorization header")
	}

	return val[1], nil
}
