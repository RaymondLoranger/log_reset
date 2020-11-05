import Config

# Mix messages in colors...
# config :elixir, ansi_enabled: true

import_config "config_logger.exs"
import_config "#{Mix.env()}.exs"

# For testing purposes only...
config :log_reset, env: Mix.env()
