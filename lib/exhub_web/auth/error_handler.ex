defmodule ExhubWeb.Auth.ErrorHandler do
  @moduledoc false

  @behaviour Guardian.Plug.ErrorHandler

  alias Plug.Conn

  def auth_error(conn, {error, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(error)})
    Conn.send_resp(conn, :unauthorized, body)
  end
end
