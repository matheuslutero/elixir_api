defmodule Restfid.Database.User do

  use Restfid.Database.Model

  @fields ~w(id
            email
            phone
            password
            password_hash
            phone
            role
            state
            person_id
            settings)a

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :phone, :string
    field :role, :string
    field :state, :string
    field :settings, :map, default: "{}"

    belongs_to :person, Restfid.Database.Person

    timestamps()
  end

  def by_email(email) do
    from(u in __MODULE__, where: u.email == ^email)
  end

  def by_phone(phone) do
    from(u in __MODULE__, where: u.phone == ^phone)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @fields)
    |> put_password_hash()
    |> validate_required([
      :email,
      :phone,
      :role,
      :state,
      :settings,
      :password_hash
    ])
    |> validate_email(:email)
    |> validate_length([:phone, :role, :state], max: 25)
    |> validate_length([:email, :password_hash], max: 255)
    |> unique_constraint(:email)
    |> unique_constraint(:phone)
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password_hash: Comeonin.Bcrypt.hashpwsalt(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end

  def fields, do: @fields
end
