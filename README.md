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

The configurable clearing levels are:

- :all (default)
- :none
- [:debug | :info | :warn | :error] (see [Logger](https://hexdocs.pm/logger/Logger.html) for other levels)

Use file `config/runtime.exs` to configure the clearing levels, for example:

```elixir
import Config

config :log_reset, levels: config_env() in [:test] && [:debug] || :all
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
