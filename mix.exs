defmodule CircleCI.Mixfile do
  use Mix.Project

  def project do
    [app: :circle_ci,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     source_url: "https://github.com/mobileoverlord/circleci",
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.13.0"},
      { :exjsx, "~> 3.2.0", app: false}
    ]
  end

  defp description do
    """
    A wrapper for interfacing with the CircleCI API.
    """
  end

  defp package do
    [maintainers: ["Justin Schneck"],
     licenses: ["Apache-2.0"],
     links: %{"GitHub" => "https://github.com/mobileoverlord/circleci"}]
  end
end
