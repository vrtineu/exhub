defmodule ExhubWeb.UsersView do
  use ExhubWeb, :view

  def render("create.json", %{user: user}), do: %{user: user}
  def render("login.json", %{token: token}), do: %{token: token}
end
