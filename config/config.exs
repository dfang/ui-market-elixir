# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pragmatic,
  ecto_repos: [Pragmatic.Repo]

# Configures the endpoint
config :pragmatic, PragmaticWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XF8PoVb+fuCvQvHbHVAIU1OLl4LVuXFG1gIlAUvzox+K9L39Vx3aSY6fRyJpTs/N",
  render_errors: [view: PragmaticWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Pragmatic.PubSub,
  live_view: [signing_salt: "FI25FgDA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
