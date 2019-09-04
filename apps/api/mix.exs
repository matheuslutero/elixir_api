defmodule Restfid.API.Mixfile do
  use Mix.Project

  def project do
    [app: :api,
     version: "0.0.1",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     preferred_cli_env: preferred_cli_env(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Restfid.API, []},
     extra_applications: [:logger]]
  end

  # Specifies which paths to compile per environment.
  # extract the libs we need for dev environment to "lib" and use
  # the "test/support" just for test enviroment
  defp elixirc_paths(_), do: ["lib", "test/support"]

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:blankable, "~> 0.0.1"},
     {:comeonin, "~> 3.0"},
     {:cors_plug, "~> 1.2"},
     {:plug_cowboy, "~> 1.0"},
     {:ex_machina, "~> 1.0"},
     {:gettext, "~> 0.11"},
     {:guardian, "~> 1.0"},
     {:phoenix, "~> 1.3.0-rc"},
     {:phoenix_ecto, "~> 3.2"},
     {:timex, "~> 3.0"},
     {:database, in_umbrella: true}]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["test.seed": ["api.test.seed"],
    "test.reset": ["ecto.drop", "ecto.create", "db.migrate", "test.seed"]]
  end

  defp preferred_cli_env do
    ["api.test.seed": :test,
     "test.seed": :test,
     "test.reset": :test]
  end
end
