import Config

# config :log_reset, reset?: config_env() in [:prod, :dev]
reset? =
  case config_env() do
    env when env in [:prod, :dev] -> true
    :staging -> :indeed
    _env -> false
  end

config :log_reset, reset?: reset?

# For testing purposes only...
config :log_reset, env: config_env()
