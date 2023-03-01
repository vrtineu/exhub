defmodule ExhubWeb.UsersController do
  use ExhubWeb, :controller

  alias Exhub.User

  action_fallback ExhubWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Exhub.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def login(conn, params) do
    with {:ok, token} <- ExhubWeb.authenticate_user(params) do
      conn
      |> put_status(:ok)
      |> render("login.json", token: token)
    end
  end
end
