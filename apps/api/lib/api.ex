defmodule Restfid.API do
  @moduledoc """
  The main app application, this is where everything starts, for now.

  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Restfid.API, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(Restfid.API.Endpoint, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Restfid.API.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def view do
    quote do
      use Phoenix.View,
        namespace: Restfid.API,
        root: "lib/api/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [view_module: 1]

      import Restfid.API.Router.Helpers

      import Restfid.API.ErrorHelpers
      import Restfid.API.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
