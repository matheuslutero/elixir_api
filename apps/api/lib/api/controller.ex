defmodule Restfid.API.Controller do
  defmacro __using__(_opts) do
    quote do
      use Phoenix.Controller, namespace: Restfid.API

      import Ecto
      import Ecto.Query

      import Restfid.API.Router.Helpers

      alias Restfid.API.Breadcrumb
    end
  end
end
