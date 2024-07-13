package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func respondWithJSON(w http.ResponseWriter, status int, payload interface{}) {

	data, err := json.Marshal(payload)
	if err != nil {
		log.Println("Failed to marshal JSON response: ", err)
		w.WriteHeader(500)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	w.Write(data)
}

func respondWithError(w http.ResponseWriter, status int, message string) {
	if status > 499 {
		log.Println("Responding with 5xx error: ", message)
	}

	type errResponse struct {
		Error string `json:"error"`
	}

	respondWithJSON(w, status, errResponse{
		Error: message,
	})

}
