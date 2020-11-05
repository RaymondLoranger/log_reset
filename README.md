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

As a dependency, this app will create and clear __all__ log files
configured in the parent app at startup.

However, for this to happen, the parent app must provide the following config:

```elixir
config :log_reset, reset?: true
```

The above config could depend on the mix environment by invoking the usual:

```elixir
import_config "#{Mix.env()}.exs"
```

You can also provide a `config/runtime.exs` file such as this one:

```elixir
import Config
config :log_reset, reset?: config_env() in [:prod, :dev]
```

After startup, the log reset can be performed selectively or globally as shown in the following examples.

## Example 1

```elixir
alias Log.Reset

@error_path Application.get_env(:logger, :error_log)[:path]
@info_path Application.get_env(:logger, :info_log)[:path]

def clear_log_files() do
  [@error_path, @info_path] |> Enum.each(&Reset.clear_log/1)
end
```

## Example 2

```elixir
alias Log.Reset

def clear_all_log_files() do
  Reset.log_paths() |> Enum.each(&Reset.clear_log/1)
end
```
