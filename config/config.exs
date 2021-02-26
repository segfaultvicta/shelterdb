# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :shelterdb,
  ecto_repos: [Shelterdb.Repo]

# Configures the endpoint
config :shelterdb, ShelterdbWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pbH61aL8SBMmScHQ3dWI0x+IfX357nHb5zB3uuSbpUovPGqaRcsB9KtW4DtZNAEF",
  render_errors: [view: ShelterdbWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Shelterdb.PubSub,
  live_view: [signing_salt: "iUgpTZxG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
