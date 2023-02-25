defmodule Exhub.GithubApi.Behaviour do
  @moduledoc """
  The Behaviour module is responsible for defining the behaviour of the GithubApi.Client module.
  """

  @callback get_user_repos(String.t(), String.t()) :: {:ok, list()} | {:error, any()}
end
