use Mix.Config

# Configure your database
config :database, Restfid.Database.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true,
  url: System.get_env("DATABASE_URL")
