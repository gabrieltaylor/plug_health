# PlugHealth

> A plug for health check, which can be used for liveness or readiness probes.

## Installation

Add `plug_health` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:plug_health, "~> 0.1.0"}
  ]
end
```

## Usage

It's better to reduce the impact of health check on application, so it's common to add this plug to the header of the endpoint.

For example:

```elixir
defmodule DemoWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :demo

  # Put the plug here, before anything else
  plug PlugHealth, path: "/alive"
end
```

In this way, the health check request is handled as light as possible, it won't pass through unnecessary plugs, such as request logger, route and controller, etc.

## Options

- `path` - the request path
- `check_func` - a function:
  - accepts one argument: `%Plug.Conn{}`.
  - returns a boolean as the result.
- `respond_func` - a function:
  - accepts two arguments: `%Plug.Conn{}` and the result from the `check_func`.
  - returns a `%Plug.Conn{}`.
