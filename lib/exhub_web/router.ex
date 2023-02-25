defmodule ExhubWeb.Router do
  use ExhubWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExhubWeb do
    pipe_through :api

    get "/repos/:user", RepoController, :show
  end
end
