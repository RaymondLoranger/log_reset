import Config

# Should be set in the parent app...
# config :log_reset, reset?: config_env() in [:test]

# For testing purposes only...
config :log_reset,
  env: "#{config_env()} ➔ from #{Path.relative_to_cwd(__ENV__.file)}"
