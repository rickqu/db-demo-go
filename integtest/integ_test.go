package main

import (
	"io"
	"net/http"
	"strings"
	"testing"
)

func TestGetAllPets(t *testing.T) {
	resp, err := http.Get("http://goapi:19229/getAllPets")
	if err != nil {
		t.Fatalf(err.Error())
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		t.Fatalf(err.Error())
	}

	stringBody := strings.Split(string(body), "\n")
	if len(stringBody) != 1 {
		t.Fatal("More than 1 pet found")
	}

	petName := strings.Fields(stringBody[0])[1]
	if petName != "Vincent" {
		t.Fatalf("Pet name not equal: " + petName)
	}
}
