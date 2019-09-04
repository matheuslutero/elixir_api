Postgrex.Types.define(Restfid.Database.PostgresTypes,
                      [Postgrex.Extensions.JSON |
                       Ecto.Adapters.Postgres.extensions()],
                      json: Jason)

