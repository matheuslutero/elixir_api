defmodule Restfid.Database.Model do
  @moduledoc """
  The restfid model basic class.
  """

  @doc false
  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset, except: [validate_length: 3]
      import Ecto.Query

      import Restfid.Database.EmailValidator
      import Restfid.Database.FieldLengthValidator
    end
  end
end
