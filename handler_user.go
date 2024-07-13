package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/google/uuid"
	"github.com/oscar-mugambi/rss-hub/internal/database"
)

func (apiCfg *apiConfig) handleCreateUser(w http.ResponseWriter, r *http.Request) {

	type parameters struct {
		Name     string `json:"name"`
		Email    string `json:"email"`
		Password string `json:"password"`
	}

	decoder := json.NewDecoder(r.Body)
	params := parameters{}
	err := decoder.Decode(&params)

	if err != nil {
		respondWithError(w, 400, fmt.Sprintf("Error decoding request body: %s", err))
	}

	user, err := apiCfg.DB.CreateUser(r.Context(), database.CreateUserParams{
		ID:           uuid.New(),
		Name:         params.Name,
		Email:        params.Email,
		PasswordHash: params.Password,
	})

	if err != nil {
		respondWithError(w, 400, fmt.Sprintf("Error creating user: %s", err))
		return
	}

	respondWithJSON(w, 200, user)
}
