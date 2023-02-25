defmodule ExhubWeb.RepoView do
  use ExhubWeb, :view

  def render("index.json", %{repos: repos}) do
    %{repos: render_many(repos, __MODULE__, "repo.json")}
  end

  def render("repo.json", %{repo: repo}) do
    %{
      id: repo.id,
      name: repo.name,
      description: repo.description,
      url: repo.html_url,
      stars: repo.stargazers_count
    }
  end
end
