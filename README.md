# HealthCheckPlug

Respond to health checks without needing a route or controller action.

Optionally, add the health check plug in your endpoint before `Plug.Logger` in order to respond
to health checks without adding noise to your logs.

## Installation

Add `plug_health` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:plug_health, "~> 0.1.0"}
  ]
end
```

Call the plug in your `endpoint.ex`

```elixir
plug HealthCheckPlug, path: "/alive"
```

### Options
- `path` - The request path
- `check_func` - A function that accepts one argument: `Plug.Conn` and, by default, returns a boolean as the result.
- `respond_func` - A function that accepts two arguments: `Plug.Conn` and the result from the `check_func`. This function
must return a `Plug.Conn`.

