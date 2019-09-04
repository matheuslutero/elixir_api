# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# General application configuration
config :database, ecto_repos: [Restfid.Database.Repo]

config :database, Restfid.Database.Repo, types: Restfid.Database.PostgresTypes

config :postgrex, :json_library, Jason

# Configure money type
config :money,
  default_currency: :BRL,
  separator: ".",
  delimeter: ",",
  symbol: false,
  symbol_on_right: false,
  symbol_space: true

config :database, namespace: Restfid.Database

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
