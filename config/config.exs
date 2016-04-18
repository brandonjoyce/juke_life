# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :juke_life, JukeLife.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "BiGj11Q3kKT6ruIANPclfK43f3AkvaNcUebalLxT+GZjzKY9vUUbqF+RLfbStsLx",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: JukeLife.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

# Configure guardian authentication
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "JukeLife",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: System.get_env("JWT_SECRET_KEY"),
  serializer: JukeLife.GuardianSerializer
