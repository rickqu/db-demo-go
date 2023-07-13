package main

import (
	"database/sql"
	"net/http"

	_ "github.com/lib/pq"
)

var db *sql.DB

func main() {
	http.HandleFunc("/version", versionHandler)
	http.HandleFunc("/getAllPets", getAllPetsHandler)
	initDB()

	http.ListenAndServe(":19229", nil)
}

func initDB() {
	var err error
	connStr := "postgres://go_user:mysecretpassword@postgres/animalshelter?sslmode=disable"
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		panic(err)
	}

	if err = db.Ping(); err != nil {
		panic(err)
	}

}

func versionHandler(respWriter http.ResponseWriter, req *http.Request) {
	if req.Method != "GET" {
		respWriter.WriteHeader(http.StatusNotFound)
		respWriter.Write([]byte("No such endpoint for method " + req.Method))
		return
	}

	respWriter.WriteHeader(http.StatusOK)
	respWriter.Write([]byte("v0.0.1"))
}

func getAllPetsHandler(respWriter http.ResponseWriter, req *http.Request) {
	rows, err := db.Query(`SELECT a.id, a.name, b.animal, a.other ->> 'personality' as personality FROM animals a JOIN animaltype b on a.animaltype = b.id`)
	if err != nil {
		respWriter.WriteHeader(http.StatusInternalServerError)
	}
	defer rows.Close()
	for rows.Next() {
		var id string
		var name string
		var animal string
		var personality string

		err = rows.Scan(&id, &name, &animal, &personality)
		if err != nil {
			respWriter.WriteHeader(http.StatusInternalServerError)
		}

		respWriter.WriteHeader(http.StatusOK)
		respWriter.Write([]byte(id + " " + name + " " + animal + " " + personality))
	}
}
