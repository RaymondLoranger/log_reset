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

This app will create and clear __all__ configured log files automatically at startup.

Afterwards it can be done selectively or globally as shown in the following examples.

## Example 1

```elixir
alias Log.Reset

@error_path Application.get_env(:logger, :error_log)[:path]
@info_path Application.get_env(:logger, :info_log)[:path]

def clear_log_files() do
  unless Mix.env() == :test do
    [@error_path, @info_path] |> Enum.each(&Reset.clear_log/1)
  end
end
```

## Example 2

```elixir
alias Log.Reset

def clear_all_log_files() do
  unless Mix.env() == :test do
    Reset.log_paths() |> Enum.each(&Reset.clear_log/1)
  end
end
```



