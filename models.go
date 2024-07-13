package main

import "github.com/oscar-mugambi/rss-hub/internal/database"

type User struct {
	ID     string `json:"id"`
	Name   string `json:"name"`
	Email  string `json:"email"`
	ApiKey string `json:"api_key"`
}

type Feed struct {
	ID     string `json:"id"`
	Name   string `json:"name"`
	Url    string `json:"url"`
	UserID string `json:"user_id"`
}

func databaseFeedToFeed(dbFeed database.Feed) Feed {
	return Feed{
		ID:     dbFeed.ID.String(),
		Name:   dbFeed.Name,
		Url:    dbFeed.Url,
		UserID: dbFeed.UserID.String(),
	}
}

func databaseFeedsToFeeds(dbFeeds []database.Feed) []Feed {
	var feeds []Feed
	for _, dbFeed := range dbFeeds {
		feeds = append(feeds, databaseFeedToFeed(dbFeed))
	}
	return feeds
}

func databaseUserToUser(dbUser database.User) User {
	return User{
		ID:     dbUser.ID.String(),
		Name:   dbUser.Name,
		Email:  dbUser.Email,
		ApiKey: dbUser.ApiKey,
	}
}
