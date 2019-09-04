use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :api, Restfid.API.Endpoint,
  http: [port: 4001],
  server: false,
  scope_opts: []

# Print only warnings and errors during test
config :logger, level: :warn

config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1

# This is for CI. When building directly to web without running any
# kind of reset before, we need to force the repo
if System.get_env("FORCE_REPO") do
  config :api, ecto_repos: [Restfid.Database.Repo]
end
