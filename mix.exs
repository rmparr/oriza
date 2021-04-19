defmodule Oriza.MixProject do
  use Mix.Project

  @source_url "https://github.com/rmparr/oriza"
  @version "0.0.3-alpha"

  def project do
    [
      app: :oriza,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore.exs",
        plt_add_deps: :app_tree,
        plt_core_path: "priv/plts",
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      description: description(),
      package: package(),
      deps: deps(),
      # Docs
      name: "Oriza",
      source_url: @source_url,
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.5.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:excoveralls, "~> 0.14.0", only: :test}
    ]
  end

  defp description do
    """
    A small utility to wrap a function in a context.

    This is used to provide secure contexts for running functions.
    """
  end

  defp package do
    [
      name: "oriza",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/rmparr/oriza"}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md",
        "CHANGELOG.md",
        "LICENSE"
      ],
      source_ref: "v#{@version}",
      source_url: @source_url,
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
    ]
  end
end
