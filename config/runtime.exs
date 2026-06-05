import Config

# Examples of configurations in the parent app...
#
#   config :log_reset, levels: :all # default
#   config :log_reset, levels: :none
#   config :log_reset, levels: [:debug, :info]

#   case config_env() do
#     :dev -> :all
#     :test -> :all
#     :prod -> :none
#     _else -> :none
#   end

# For testing purposes only...
config :log_reset,
  env: "#{config_env()} ➔ from #{Path.relative_to_cwd(__ENV__.file)}"
