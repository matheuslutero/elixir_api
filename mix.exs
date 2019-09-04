defmodule Restfid.MixProject do
  use Mix.Project

  def project do
    [apps_path: "apps",
    build_embedded: Mix.env() == :prod,
    start_permanent: Mix.env() == :prod,
    aliases: aliases(),
    preferred_cli_env: preferred_cli_env(),
    deps: deps()]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [{:credo, "~> 0.7", only: [:dev, :test]}]
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
    ["database.test.seed": :test,
     "test.seed": :test,
     "test.reset": :test]
  end
end
