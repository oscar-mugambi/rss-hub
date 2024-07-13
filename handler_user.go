package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/google/uuid"
	"github.com/oscar-mugambi/rss-hub/internal/auth"
	"github.com/oscar-mugambi/rss-hub/internal/database"
	"golang.org/x/crypto/bcrypt"
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
		return
	}

	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(params.Password), bcrypt.DefaultCost)

	if err != nil {
		respondWithError(w, 400, fmt.Sprintf("Error decoding request body: %s", err))
	}

	user, err := apiCfg.DB.CreateUser(r.Context(), database.CreateUserParams{
		ID:           uuid.New(),
		Name:         params.Name,
		Email:        params.Email,
		PasswordHash: string(hashedPassword),
	})

	if err != nil {
		respondWithError(w, 400, fmt.Sprintf("Error creating user: %s", err))
		return
	}

	respondWithJSON(w, 201, databaseUserToUser(user))
}

func (apiCfg *apiConfig) handleGetUserByApiKey(w http.ResponseWriter, r *http.Request) {

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

	respondWithJSON(w, 200, databaseUserToUser(user))

}
