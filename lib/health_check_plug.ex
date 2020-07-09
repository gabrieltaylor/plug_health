defmodule HealthCheckPlug do
  @moduledoc """
  Respond to ready and alive checks

  ## Optons
  path: the request path
  check_func: a function that accepts one argument: Plug.Conn
  respond_func: a function two arguments: the Plug.Conn and the result of the check function as arguments

  ## Examples
  ```
  plug HealthCheckPlug, path: "/alivez"
  plug HealthCheckPlug, path: "/readyz"
  ```
  """

  @behaviour Plug

  import Plug.Conn

  def defaults do
    [
      path: "/health",
      respond_func: &respond/2,
      check_func: &check/1
    ]
  end

  def init(opts) do
    defaults()
    |> Keyword.merge(opts)
  end

  def call(%Plug.Conn{request_path: req_path} = conn, opts) do
    case req_path == opts[:path] do
      true ->
        result = opts[:check_func].(conn)
        opts[:respond_func].(conn, result)
      false -> conn
    end
  end

  def call(conn, _opts), do: conn

  defp respond(conn, true = _check_result) do
    conn
    |> put_resp_content_type("application/json", nil)
    |> send_resp(:ok, ~s({"healthy": true}))
    |> halt()
  end

  defp respond(conn, false = _check_result) do
    conn
    |> put_resp_content_type("application/json", nil)
    |> send_resp(:service_unavailable, ~s({"healthy": false}))
    |> halt()
  end

  defp check(_conn), do: true
end
