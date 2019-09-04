defmodule MasterProxy.Mixfile do
  use Mix.Project

  def project do
    [app: :master_proxy,
    version: "0.1.0",
    build_path: "../../_build",
    config_path: "../../config/config.exs",
    deps_path: "../../deps",
    lockfile: "../../mix.lock",
    elixir: "~> 1.4",
    build_embedded: Mix.env == :prod,
    start_permanent: Mix.env == :prod,
    aliases: aliases(),
    preferred_cli_env: preferred_cli_env(),
    deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {MasterProxy.Application, []}]
  end

  defp deps do
    [{:plug_cowboy, "~> 1.0"},
     {:plug, "~> 1.2"},

     {:api, in_umbrella: true}]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    []
  end

  defp preferred_cli_env do
    []
  end
end
