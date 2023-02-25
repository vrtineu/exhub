defmodule ExhubWeb.FallbackController do
  use ExhubWeb, :controller

  alias Exhub.Error

  def call(conn, {:error, %Error{message: message, status_code: status_code}}) do
    IO.inspect(message)

    conn
    |> put_status(status_code)
    |> put_view(ExhubWeb.ErrorView)
    |> render("error.json", message: message)
  end
end
