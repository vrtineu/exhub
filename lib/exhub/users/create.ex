defmodule Exhub.Users.Create do
  @moduledoc """
  The Create module is responsible for creating a new user.
  """

  def call(params) do
    %Exhub.User{}
    |> Exhub.User.changeset(params)
    |> IO.inspect()
    |> Exhub.Repo.insert()
  end
end
