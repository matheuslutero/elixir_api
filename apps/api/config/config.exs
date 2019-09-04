# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api, ecto_repos: []

# Configures the endpoint
config :api, Restfid.API.Endpoint,
  url: [host: "lvh.me"],
  render_errors: [view: Restfid.API.ErrorView, accepts: ~w(json)]

config :api, Restfid.API.Guardian,
  issuer: "api",
  secret_key: "ukAWTKGm0GtoXb0Hf3ZcpKGYxdnL0NsKDqaps43YXO9P1lTNlpc5aytzNgj4Az8Q"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :api, namespace: Restfid.API

config :api, Restfid.API.Gettext, default_locale: "en"

config :phoenix, :template_engines,
  eex: Phoenix.Template.EExEngine,
  exs: Phoenix.Template.ExsEngine

config :phoenix, :format_encoders, json: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
