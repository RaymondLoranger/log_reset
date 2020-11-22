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

As a dependency, this app will, by default, create and clear __all__ log files
configured in the parent app at startup.

The parent app may provide different clearing options, for example:

```elixir
config :log_reset, levels: :none
```

```elixir
config :log_reset, levels: [:error, :info]
```

The above config could depend on the mix environment by invoking the usual:

```elixir
import_config "#{Mix.env()}.exs"
```

You can also provide a `config/runtime.exs` file such as this one:

```elixir
import Config

config :log_reset, levels: config_env() in [:test] && :all || :none
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
