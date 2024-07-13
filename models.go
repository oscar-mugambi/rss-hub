package main

import "github.com/oscar-mugambi/rss-hub/internal/database"

type User struct {
	ID     string `json:"id"`
	Name   string `json:"name"`
	Email  string `json:"email"`
	ApiKey string `json:"api_key"`
}

func databaseUserToUser(dbUser database.User) User {
	return User{
		ID:     dbUser.ID.String(),
		Name:   dbUser.Name,
		Email:  dbUser.Email,
		ApiKey: dbUser.ApiKey,
	}
}
