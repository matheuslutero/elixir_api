defmodule Restfid.Database.FieldLengthValidator do
  def validate_length(changeset, fields, options) when is_list(fields) do
    Enum.reduce(fields, changeset, fn field, cs ->
      validate_length(cs, field, options)
    end)
  end

  defdelegate validate_length(changeset, field, options), to: Ecto.Changeset
end
