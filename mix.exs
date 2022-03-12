defmodule PlugHealth.MixProject do
  use Mix.Project

  def project do
    [
      app: :plug_health,
      version: "0.1.2",
      elixir: "~> 1.9",
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/gabrieltaylor/plug_health",
      docs: [
        extras: ~W(README.md)
      ]
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

  defp description do
    """
    A plug for health check, which can be used for liveness or readiness probes.
    """
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md LICENSE),
      maintainers: ["Gabriel Taylor Russ"],
      licenses: ["MIT"],
      links: %{
        "Github" => "http://github.com/gabrieltaylor/plug_health"
      }
    ]
  end
end
