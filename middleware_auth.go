package main

import (
	"fmt"
	"net/http"

	"github.com/oscar-mugambi/rss-hub/internal/auth"
	"github.com/oscar-mugambi/rss-hub/internal/database"
)

type authedHandler func(w http.ResponseWriter, r *http.Request, user database.User)

func (apiCfg *apiConfig) middlewareAuth(handler authedHandler) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		apiKey, err := auth.GetApiKey(r.Header)
		if err != nil {
			respondWithError(w, 403, fmt.Sprintf("Error getting api key: %s", err))
			return
		}

		user, err := apiCfg.DB.GetUserByAPIKey(r.Context(), apiKey)
		if err != nil {
			respondWithError(w, 404, fmt.Sprintf("Error getting user: %s", err))
			return
		}

		handler(w, r, user)
	}
}
