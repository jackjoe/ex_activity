defmodule ExActivity.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_activity,
      version: "0.1.4",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      package: package(),
      start_permanent: Mix.env == :prod,
      deps: deps(),

      # Docs
      name: "ExActivity",
      description: "ExActivity, log Activity to your repo",
      docs: [extras: ["README.md"], main: "readme"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 2.1"},
      {:ex_doc, "~> 0.16.0", only: :dev},
      {:mariaex, "~> 0.8.2", only: [:dev, :test]},
      {:dialyxir, "~> 0.5", [only: [:dev, :test]]},
      {:credo, "~> 0.8", [only: [:dev, :test]]}
    ]
  end

  defp package do
    [
      files:       ["lib", "mix.exs", "README.md"],
      maintainers: ["Jeroen Bourgois <jeroen@jackjoe.be>", "Pieter Michels <pieter@jackjoe.be>"],
      organization: "jackjoe",
      licenses:    ["COPYRIGHT"],
      links:       []
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
