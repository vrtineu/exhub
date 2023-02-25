defmodule ExhubWeb.RepoView do
  use ExhubWeb, :view

  def render("show.json", %{repos: repos}) do
    %{repos: render_many(repos, __MODULE__, "repo.json")}
  end

  def render("repo.json", %{} = map_repo) do
    %Exhub.GithubApi.Client{} = repo = Map.get(map_repo, :repo)

    %{
      id: repo.id,
      name: repo.name,
      description: repo.description,
      url: repo.html_url,
      stargazers_count: repo.stargazers_count
    }
  end
end
