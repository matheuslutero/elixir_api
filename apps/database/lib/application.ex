defmodule Restfid.Database.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Restfid.Database.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: Restfid.Database.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
