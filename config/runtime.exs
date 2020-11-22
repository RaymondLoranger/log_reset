import Config

# Should be configured in the parent app...
# config :log_reset, levels: [:error, :info]

# For testing purposes only...
config :log_reset,
  env: "#{config_env()} ➔ from #{Path.relative_to_cwd(__ENV__.file)}"
