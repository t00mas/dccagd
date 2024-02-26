package server

import (
	"fmt"
	"net/http"

	"github.com/t00mas/dccagd/pkg/handlers"
)

type Server struct {
	Port string
}

func NewServer() *Server {
	return &Server{
		Port: "8080",
	}
}

func (s *Server) Run() error {
	http.HandleFunc("/hello", handlers.Hello)
	err := http.ListenAndServe(fmt.Sprintf(":%s", s.Port), nil)
	if err != nil {
		return err
	}
	return nil
}
