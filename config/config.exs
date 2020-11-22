import Config

# Mix messages in colors...
# config :elixir, ansi_enabled: true

import_config "config_logger.exs"

# Should be set in the parent app...
config :log_reset, reset?: Mix.env() in [:test]

# For testing purposes only...
config :log_reset,
  env: "#{Mix.env()} ➔ from #{Path.relative_to_cwd(__ENV__.file)}"
