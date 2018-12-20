defmodule Log.Reset.MixProject do
  use Mix.Project

  def project do
    [
      app: :log_reset,
      version: "0.1.4",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      name: "Log Reset",
      source_url: source_url(),
      description: description(),
      package: package(),
      deps: deps(),
      dialyzer: [plt_add_apps: [:mix]]
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/log_reset"
  end

  defp description do
    """
    Creates and clears configured log files.
    """
  end

  defp package do
    [
      files: [
        "lib",
        "mix.exs",
        "README*",
        "config/dev.exs",
        "config/prod.exs",
        "config/test.exs"
      ],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Log.Reset.App, :ok}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_tasks,
       github: "RaymondLoranger/mix_tasks", only: :dev, runtime: false},
      {:persist_config, "~> 0.1"},
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false}
    ]
  end
end
