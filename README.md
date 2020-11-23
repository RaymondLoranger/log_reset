# Log Reset

Creates and clears configured log files.

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

As a dependency, this app will normally create and clear __all__ log files
configured in the parent app at startup.

The log levels of the log files to be cleared can be specified as follows:

config :log_reset, levels: _levels_

where _levels_ can be:
  :all
  |:none
  | [[Logger.level](https://hexdocs.pm/logger/Logger.html#t:level/0)]

Use file `config/runtime.exs` to configure the above log levels, for example:

```elixir
import Config

config :log_reset, levels: config_env() in [:test] && [:debug, :info] || :all
```

After startup, log reset can be performed selectively or globally:

## Example 1

```elixir
alias Log.Reset

# Clears configured log files of levels :error and :info.
Reset.clear_logs([:error, :info])
```

## Example 2

```elixir
alias Log.Reset

# Clears all configured log files.
Reset.clear_logs(:all)
```
