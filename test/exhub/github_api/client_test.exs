defmodule Exhub.GithubApi.ClientTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Exhub.GithubApi.Client

  describe "get_user_repos/1" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "returns a list of repositories for a given user", %{bypass: bypass} do
      url = endpoint_url(bypass.port)

      body = ~s([
        {
          "id": 1,
          "name": "exhub",
          "description": "A simple Elixir client for the Github API",
          "html_url": "https://github.com/vrtineu/exhub",
          "stargazers_count": 0
        }
      ])

      username = "vrtineu"

      Bypass.expect(bypass, "GET", "/users/#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = Client.get_user_repos(url, username)

      expected_response =
        {:ok,
         [
           %Exhub.GithubApi.Client{
             id: 1,
             name: "exhub",
             description: "A simple Elixir client for the Github API",
             html_url: "https://github.com/vrtineu/exhub",
             stargazers_count: 0
           }
         ]}

      assert response == expected_response
    end

    test "returns an error when the user is not found", %{bypass: bypass} do
      url = endpoint_url(bypass.port)

      username = "invalid_user"

      Bypass.expect(bypass, "GET", "/users/#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(404, "")
      end)

      response = Client.get_user_repos(url, username)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
