defmodule PlugHealthTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import Plug.Conn, only: [get_resp_header: 2]

  test "responds to /health by default" do
    opts = PlugHealth.init([])

    conn =
      :get
      |> conn("/health")
      |> PlugHealth.call(opts)

    assert conn.halted
  end

  test "does not respond to /other-paths by default" do
    opts = PlugHealth.init([])

    conn =
      :get
      |> conn("/other-paths")
      |> PlugHealth.call(opts)

    refute conn.halted
  end

  test "sets the response body" do
    opts = PlugHealth.init([])

    conn =
      :get
      |> conn("/health")
      |> PlugHealth.call(opts)

    assert conn.resp_body == ~s({"healthy": true})
  end

  test "sets the content type" do
    opts = PlugHealth.init([])

    conn =
      :get
      |> conn("/health")
      |> PlugHealth.call(opts)

    assert ["application/json"] == get_resp_header(conn, "content-type")
  end

  test "supports setting the path in options" do
    opts = PlugHealth.init(path: "/foo")

    conn =
      :get
      |> conn("/foo")
      |> PlugHealth.call(opts)

    assert conn.halted
  end

  test "supports setting the response function in options" do
    opts = PlugHealth.init(respond_func: &test_respond_func/2)

    conn =
      :get
      |> conn("/health")
      |> PlugHealth.call(opts)

    assert conn.resp_body == ~s({"hello-from-the-test": true})
    assert conn.halted
  end

  test "supports setting the check function in options" do
    opts = PlugHealth.init(check_func: fn _conn -> true end)

    conn =
      :get
      |> conn("/health")
      |> PlugHealth.call(opts)

    assert conn.resp_body == ~s({"healthy": true})
    assert conn.halted
  end

  def test_respond_func(conn, true) do
    conn
    |> Plug.Conn.send_resp(:ok, ~s({"hello-from-the-test": true}))
    |> Plug.Conn.halt()
  end

  def test_respond_func(conn, false) do
    conn
    |> Plug.Conn.send_resp(:service_unavailable, ~s({"hello-from-the-test": false}))
    |> Plug.Conn.halt()
  end
end
