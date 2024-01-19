package main

import (
	"fmt"
	"io"
	"log"
	"net/http"

	"github.com/julienschmidt/httprouter"
)

func main() {
	fmt.Println("Listening on port 8080")

	router := httprouter.New()
	router.GET("/", indexHandler)
	router.GET("/crash", crashHandler)
	http.ListenAndServe(":8080", router)
}

func indexHandler(res http.ResponseWriter, req *http.Request, _ httprouter.Params) {
	io.WriteString(res, "Hello from a Kubernetes! V2")
}

func crashHandler(res http.ResponseWriter, req *http.Request, _ httprouter.Params) {
	log.Println("User request server crash, crashing the server now...")
	io.WriteString(res, "Crashing the Docker Container!")
	log.Fatalln("Server Crashed!")
}
