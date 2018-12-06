# Log Reset

Creates and clears log files.

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

```elixir
alias Log.Reset

@error_path Application.get_env(:logger, :error_log)[:path]
@info_path Application.get_env(:logger, :info_log)[:path]
@warn_path Application.get_env(:logger, :warn_log)[:path]

@spec start(Application.start_type(), term) :: {:ok, pid}
def start(_type, :ok) do
  unless Mix.env() == :test do
    [@error_path, @info_path, @warn_path] |> Enum.each(&LogReset.clear_log/1)
  end
...
end
