defmodule FlyDistSys.MixProject do
  use Mix.Project

  def project do
    [
      app: :fly_dist_sys,
      version: "0.1.0",
      elixir: "~> 1.14",
      escript: escript(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {FlyDistSys.Application, []}
    ]
  end

  def escript do
    [
      main_module: FlyDistSys.Listener
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.4"}
    ]
  end
end
