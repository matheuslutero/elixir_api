defmodule Restfid.API.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  require Restfid.API.Gettext

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # Because error messages were defined within Ecto, we must
    # call the Gettext module passing our Gettext backend. We
    # also use the "errors" domain as translations are placed
    # in the errors.po file.
    # Ecto will pass the :count keyword if the error message is
    # meant to be pluralized.
    # On your own code and templates, depending on whether you
    # need the message to be pluralized or not, this could be
    # written simply as:
    #
    #     dngettext "errors", "1 file", "%{count} files", count
    #     dgettext "errors", "is invalid"
    #
    if count = opts[:count] do
      Gettext.dngettext(Restfid.API.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(Restfid.API.Gettext, "errors", msg, opts)
    end
  end

  @doc """
  Translates a field name using gettext
  """
  def translate_field(field) when is_atom(field) do
    field
    |> Atom.to_string()
    |> translate_field
  end

  def translate_field(field) do
    Gettext.dgettext(Restfid.API.Gettext, "fields", field)
  end

  @doc """
  Concatenates the results of 'translate_field' with 'translate_error'
  """
  def translate_full_error(:base, error), do: translate_error(error)

  def translate_full_error(field, error) do
    Restfid.API.Gettext.gettext("The field %{field} %{msg}",
      field: translate_field(field),
      msg: translate_error(error)
    )
  end

  def translate_full_errors(errors) do
    for {field, error} <- errors do
      translate_full_error(field, error)
    end
  end
end
