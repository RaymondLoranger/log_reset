# Log Reset

Resets configured log files.

## Installation

Add `log_reset` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:log_reset, "~> 0.1"}
  ]
end
```

## Usage

As a dependency, this app will (by default) reset __all__ log files
configured in the parent app at startup.

The log levels of the log files to be reset can be:

- :all (default)
- :none
- [[Logger.level()](https://hexdocs.pm/logger/Logger.html#t:level/0)]

You may use file `config/runtime.exs` to configure the above log levels:

```elixir
import Config

config :log_reset, levels: [:debug, :info]
```

After startup, log reset can be performed selectively or globally:

#### Example 1

```elixir
alias Log.Reset

# Resets configured log files of levels :error and :info.
Reset.reset_logs([:error, :info])
```

#### Example 2

```elixir
alias Log.Reset

# Resets all configured log files.
Reset.reset_logs(:all)
```
