# Log Reset

Creates and clears configured log files.

## Installation

Add `log_reset` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:log_reset, github: "RaymondLoranger/log_reset"}
  ]
end
```

## Usage

This app will create and clear all configured log files at startup.
It can also be done programmatically as shown in the example below.

```elixir
alias Log.Reset

@error_path Application.get_env(:logger, :error_log)[:path]
@info_path Application.get_env(:logger, :info_log)[:path]
@warn_path Application.get_env(:logger, :warn_log)[:path]

def clear_log_files() do
  unless Mix.env() == :test do
    [@error_path, @info_path, @warn_path] |> Enum.each(&Reset.clear_log/1)
  end
end
