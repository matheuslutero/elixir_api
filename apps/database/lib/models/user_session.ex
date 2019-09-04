defmodule Restfid.Database.UserSession do

  use Restfid.Database.Model

  @fields ~w(id
            user_id
            token
            device_model
            device_platform
            notification_player_id
            app_version
            expiration_date)a

  schema "user_sessions" do
    field :token, :string
    field :device_model, :string
    field :device_platform, :string
    field :notification_player_id, :string
    field :app_version, :string
    field :expiration_date, :utc_datetime

    belongs_to :user, Restfid.Database.User

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @fields)
    |> validate_required([
      :user_id,
      :token,
      :app_version,
      :expiration_date
    ])
    |> validate_length([
      :device_platform,
      :app_version], max: 25)
    |> validate_length([
      :device_model,
      :notification_player_id
    ], max: 255)
    |> validate_length([
      :token], max: 500)
  end

  def fields, do: @fields
end
