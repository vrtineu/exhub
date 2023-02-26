defmodule ExhubWeb.RepoController do
  use ExhubWeb, :controller

  action_fallback ExhubWeb.FallbackController

  def show(conn, %{"user" => user}) do
    with {:ok, repos} <- Exhub.fetch_repos(user) do
      conn
      |> put_status(:ok)
      |> render("show.json", repos: repos)
    end
  end
end
