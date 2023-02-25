defmodule Exhub.GithubApi.Behaviour do
  @moduledoc """
  The Behaviour module is responsible for defining the behaviour of the GithubApi.Client module.
  """

  @typep client_result :: {:ok, [Exhub.Github.Client.t()]} | {:error, Exhub.Error.t()}

  @callback get_user_repos(String.t()) :: client_result
  @callback get_user_repos(String.t(), String.t()) :: client_result
end
