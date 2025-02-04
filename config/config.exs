import Config

config :elixir, ansi_enabled: true

import_config "config_logger.exs"

# For testing purposes only...
config :log_reset,
  env: "#{Mix.env()} ➔ from #{Path.relative_to_cwd(__ENV__.file)}"
