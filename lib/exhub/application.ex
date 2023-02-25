defmodule Exhub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Exhub.Repo,
      # Start the Telemetry supervisor
      ExhubWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Exhub.PubSub},
      # Start the Endpoint (http/https)
      ExhubWeb.Endpoint
      # Start a worker by calling: Exhub.Worker.start_link(arg)
      # {Exhub.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exhub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExhubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
