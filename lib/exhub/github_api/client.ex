defmodule Exhub.GithubApi.Client do
  @moduledoc """
  The Client module is responsible for making requests to the Github API.
  """

  @behaviour Exhub.GithubApi.Behaviour

  use Tesla

  alias Exhub.Error
  alias Tesla.Env

  @base_url "https://api.github.com"

  defstruct [:id, :name, :description, :html_url, :stargazers_count]

  plug Tesla.Middleware.Headers, [{"User-Agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  @doc """
  Returns a list of repositories for a given user.

  ## Examples

      iex> Exhub.GithubApi.Client.get_user_repos("vrtineu")
      {:ok, [%Exhub.GithubApi.Client{
        id: 1,
        name: "exhub",
        description: "A simple Elixir client for the Github API",
        html_url: "https://github.com/vrtineu/exhub",
        stargazers_count: 0
      }]}

      iex> Exhub.GithubApi.Client.get_user_repos("invalid_user")
      {:error, %Exhub.Error{message: "User not found", status_code: :not_found}}
  """
  def get_user_repos(base_url \\ @base_url, user) do
    "#{base_url}/users/#{user}/repos"
    |> get()
    |> handle_response()
  end

  defp handle_response({:ok, %Env{status: 404}}) do
    {:error, Error.new("User not found", :not_found)}
  end

  defp handle_response({:ok, %Env{status: 200, body: body}}) do
    {:ok, Enum.map(body, &to_struct/1)}
  end

  defp to_struct(%{
         "id" => id,
         "name" => name,
         "description" => description,
         "html_url" => html_url,
         "stargazers_count" => stargazers_count
       }) do
    %__MODULE__{
      id: id,
      name: name,
      description: description,
      html_url: html_url,
      stargazers_count: stargazers_count
    }
  end
end
