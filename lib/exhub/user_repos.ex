defmodule Exhub.UserRepos do
  @moduledoc """
  The UserRepos module is responsible for fetching the user's repositories.
  """
  alias Exhub.Error
  alias Exhub.GithubApi.Client

  @doc """
  Fetches the user's repositories.
  """
  def fetch_repos(username) do
    case github_client().get_user_repos(username) do
      {:ok, [%Client{} | _] = repos} -> {:ok, repos}
      {:error, message} -> {:error, Error.new(message, :not_found)}
    end
  end

  defp github_client do
    :exhub
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:github_api_adapter)
  end
end
