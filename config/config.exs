# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tiny,
  ecto_repos: [Tiny.Repo]

config :tiny, :urls, domain: 'http://localhost:4000/?u=', max_alive_days: 10 #days

# Configures the endpoint
config :tiny, TinyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tbc6/LXdOfUISArg+lGKWfO1vqv4Re1/fyJXTfAUX+oa48vwSUK5B9n4/v2hPsvY",
  render_errors: [view: TinyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tiny.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
