defmodule ExhubWeb.Router do
  use ExhubWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ExhubWeb.Auth.Pipeline
  end

  scope "/api", ExhubWeb do
    pipe_through [:api, :auth]

    get "/repos/:user", RepoController, :show
  end

  scope "/api", ExhubWeb do
    pipe_through :api

    post "/users", UsersController, :create
    post "/users/login", UsersController, :login
  end
end
