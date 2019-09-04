defmodule Restfid.API.Router do
  use Phoenix.Router

  @scope_opts :api
              |> Application.get_env(Restfid.API.Endpoint)
              |> Keyword.get(:scope_opts, [])

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :jwt_authenticated do
    plug(Restfid.API.Guardian.AuthPipeline)
  end

  scope "/", Restfid.API, @scope_opts do
    pipe_through([:api])

    resources("/user_sessions", UserSessionController, only: [:create])
    resources("/persons", PersonController, only: [:create])
    resources("/users", UserController, only: [:create])
  end

  scope "/", Restfid.API, @scope_opts do
    pipe_through([:api, :jwt_authenticated])

    resources("/persons", PersonController, except: [:create])
    resources("/users", UserController, except: [:create])
  end
end
