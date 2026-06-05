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

As a dependency, this app will (by default) reset <ins>all</ins> log files
configured in the parent app at <ins>startup</ins>.

To reset specific files at <ins>startup</ins>, simply list their log levels
under the `:levels` key.

For example, to only reset log files of levels `:debug` and `:info`:

```elixir
import Config

config :log_reset, levels: [:debug, :info]
```

The log levels of the files to be reset can be:

- :all (default)
- :none
- [[Level]](https://hexdocs.pm/logger/Logger.html#module-levels)

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
