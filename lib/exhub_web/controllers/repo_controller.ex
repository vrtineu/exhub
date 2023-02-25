defmodule ExhubWeb.RepoController do
  use ExhubWeb, :controller

  def show(conn, %{"user" => user}) do
    with {:ok, repos} <- Exhub.get_user_repos(user) do
      conn
      |> put_status(:ok)
      |> render("show.json", repos: repos)
    end
  end
end
