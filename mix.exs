defmodule ExActivity.Mixfile do
  use Mix.Project

  @project_url "https://github.com/jackjoe/ex_activity"
  @version "0.1.23"

  def project do
    [
      app: :ex_activity,
      version: @version,
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      package: package(),
      start_permanent: Mix.env == :prod,
      deps: deps(),

      # Docs
      name: "ExActivity",
      description: "Log Activity to your repo, using Ectro",
      docs: [extras: ["README.md"], main: "readme"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExActivity.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 2.1"},
      {:ex_doc, "~> 0.16.0", only: :dev},
      {:mariaex, "~> 0.8.2"},
      {:dialyxir, "~> 0.5", [only: [:dev, :test, :travis]]},
      {:credo, "~> 0.8", [only: [:dev, :test, :travis]]}
    ]
  end

  defp package do
    [
      files:        ["lib", "mix.exs", "README.md"],
      maintainers:  ["Jeroen Bourgois", "Pieter Michels"],
      organization:  "jackjoe",
      licenses:     ["MIT"],
      links: %{
        "GitHub" => @project_url,
        "Made by jackjoe" => "https://jackjoe.be/en",
      }
    ]
  end

  # applications: [],
  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test) do
    ["lib", "test/support"]
  end

  defp elixirc_paths(_) do
    ["lib"]
  end
end
