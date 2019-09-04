defmodule Restfid.Database.EmailValidator do
  import Ecto.Changeset

  def validate_email(changeset, field) do
    validate_format(changeset, field, ~r/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/ui)
  end
end
