defmodule ExhubWeb.Auth.Guardian do
  @moduledoc """
  The Guardian module is responsible for encoding and decoding tokens.
  """

  use Guardian, otp_app: :exhub

  alias Exhub.Error
  alias Exhub.User
  alias Exhub.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UserGet.by_id()
  end

  def authenticate_user(%{"id" => id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      _ -> {:error, Error.new("Invalid credentials", :unauthorized)}
    end
  end

  def authenticate_user(_), do: {:error, Error.new("Invalid credentials", :unauthorized)}
end
