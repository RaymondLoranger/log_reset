import Config

# Mix messages in colors...
# config :elixir, ansi_enabled: true

import_config "config_logger.exs"
import_config "#{Mix.env()}.exs"

# For testing purposes only...
config :log_reset,
  env: "#{config_env()} ➔ from #{Path.relative_to_cwd(__ENV__.file)}"
