defmodule ExhubWeb.UsersView do
  use ExhubWeb, :view

  def render("create.json", %{user: user}) do
    %{user: user}
  end
end
