defmodule GithubIssues.Mixfile do
  use Mix.Project

  def project do
    [
      app: :github_issues,
      escript: escript_config(),
      version: "0.1.0",
      elixir: "~> 1.5",
      name: "Github Issues Fetcher",
      start_permanent: Mix.env == :prod,
      deps: deps()
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
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.18.1"},
      {:earmark, "~> 1.2.4"}
    ]
  end

  defp escript_config do
    [ main_module: GithubIssues.CLI ]
  end
end
