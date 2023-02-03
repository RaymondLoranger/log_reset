import Config

# Logging levels ordered by importance or severity...
# However :warning and :warn have the same severity...
config :file_only_logger,
  levels: [
    :emergency,
    :alert,
    :critical,
    :error,
    :warning,
    :warn,
    :notice,
    :info,
    :debug
  ]
