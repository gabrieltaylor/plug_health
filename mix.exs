defmodule PlugHealth.MixProject do
  use Mix.Project

  @version "1.0.0"
  @source_url "https://github.com/gabrieltaylor/plug_health"
  @description "A plug for health check, which can be used for liveness or readiness probes."

  def project do
    [
      app: :plug_health,
      version: @version,
      elixir: "~> 1.9",
      deps: deps(),
      description: @description,
      homepage_url: @source_url,
      package: package(),
      aliases: aliases(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:plug, "~> 1.5"}
    ]
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md LICENSE),
      maintainers: ["Gabriel Taylor Russ"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end

  defp aliases do
    [publish: ["hex.publish", "tag"], tag: &tag_release/1]
  end

  defp tag_release(_) do
    Mix.shell().info("Tagging release as #{@version}")
    System.cmd("git", ["tag", @version])
    System.cmd("git", ["push", "--tags"])
  end

  defp docs do
    [
      extras: ~W(README.md),
      main: "readme",
      source_url: @source_url,
      source_ref: @version
    ]
  end
end
