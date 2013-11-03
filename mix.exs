defmodule ExFirebase.Mixfile do
  use Mix.Project

  def project do
    [ app: :exfirebase,
      version: "0.0.1",
      elixir: ">= 0.10.2-dev",
      deps: deps(Mix.env),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  def deps(:test) do
    deps(:dev)
  end

  def deps(:dev) do
    deps(:prod) ++
      [
        {:mock, github: "parroty/mock", branch: "version"},
        {:excoveralls, github: "parroty/excoveralls"},
        {:exvcr, github: "parroty/exvcr"}
      ]
  end

  def deps(:prod) do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", ref: "866b0ff5aca229f1ef53653eabc8ed1720c13cd6", override: true},
      {:json, github: "parroty/elixir-json", branch: "version"},
      {:httpotion, github: "parroty/httpotion", branch: "version"}
    ]
  end
end
