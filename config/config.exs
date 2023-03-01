# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :exhub,
  ecto_repos: [Exhub.Repo],
  generators: [binary_id: true]

config :exhub, Exhub.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :exhub, ExhubWeb.Auth.Guardian,
  issuer: "Exhub",
  secret_key: "DDBkjcgc3QKJAoIq3txryOcc18lig8JxFuSo+YCsCG7dBjp5XkGKMchsmo8kuGU2"

config :exhub, ExhubWeb.Auth.Pipeline,
  module: ExhubWeb.Auth.Guardian,
  error_handler: ExhubWeb.Auth.ErrorHandler

config :exhub, Exhub.UserRepos, github_api_adapter: Exhub.GithubApi.Client

# Configures the endpoint
config :exhub, ExhubWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ExhubWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Exhub.PubSub,
  live_view: [signing_salt: "CZ7ot1M0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
