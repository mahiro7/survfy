# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :survfy,
  ecto_repos: [Survfy.Repo]

# Configures the endpoint
config :survfy, SurvfyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KClUfJzqveKD7MNhqUUb14rGZ2Z034RBh+LC/MSZrWoTtWromB4rnUHHyRs9v6ty",
  render_errors: [view: SurvfyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Survfy.PubSub,
  live_view: [signing_salt: "caUA45cC"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
