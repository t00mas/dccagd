package main

import (
	"os"

	"github.com/t00mas/dccagd/pkg/server"
)

func main() {
	server := server.NewServer()
	err := server.Run()
	if err != nil {
		panic(err)
	}
	os.Exit(0)
}
