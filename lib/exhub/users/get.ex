defmodule Exhub.Users.Get do
  @moduledoc false
  alias Exhub.Error

  def by_id(id) do
    case Exhub.Repo.get(Exhub.User, id) do
      nil -> {:error, Error.new("User not found", :not_found)}
      user -> {:ok, user}
    end
  end
end
