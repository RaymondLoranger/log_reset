import Config

# config :log_reset, reset?: config_env() in [:test]
reset? =
  case config_env() do
    env when env in [:test] -> true
    :staging -> :indeed
    _env -> false
  end

config :log_reset, reset?: reset?

# For testing purposes only...
config :log_reset,
  env: "#{config_env()} ➔ from #{Path.relative_to_cwd(__ENV__.file)}"
