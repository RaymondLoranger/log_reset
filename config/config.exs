import Config

config :elixir, ansi_enabled: true

# import_config "config_logger.exs"

# Examples of configurations in the parent app...
#
#   config :log_reset, levels: :all # default
#   config :log_reset, levels: :none
#   config :log_reset, levels: [:debug, :info]

# For testing purposes only...
config :log_reset,
  env: "#{Mix.env()} ➔ from #{Path.relative_to_cwd(__ENV__.file)}"
