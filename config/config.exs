# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :dunkan,
  ecto_repos: [Dunkan.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :dunkan, DunkanWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: DunkanWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Dunkan.PubSub,
  live_view: [signing_salt: "ZEO0LdMc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guardian authentication
config :dunkan, Dunkan.Contexts.Users.AuthUserContext.Guardian,
  issuer: "dunkan-backend",
  secret_key: "3UD5rwEUSZJOA2xk+ctLZvBFJ+GAL8rDWBC5SXDvvEzswYInGSvEZR6d2miaV5Cg"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures GuardianDB tokens storage
config :guardian, Guardian.DB,
  # Add your repository module
  repo: Dunkan.Repo,
  # default
  schema_name: "guardian_tokens"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
