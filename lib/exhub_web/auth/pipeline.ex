defmodule ExhubWeb.Auth.Pipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline, otp_app: :exhub

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
