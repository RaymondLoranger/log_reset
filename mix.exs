defmodule Log.Reset.MixProject do
  use Mix.Project

  def project do
    [
      app: :log_reset,
      version: "0.1.51",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      name: "Log Reset",
      source_url: source_url(),
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/log_reset"
  end

  defp description do
    """
    Resets configured log files.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Log.Reset.TopSup, :ok}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:file_only_logger, "~> 0.1"},
      {:persist_config, "~> 0.4", runtime: false}
    ]
  end
end
