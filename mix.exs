defmodule AtomBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :atom_bot,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      atomvm: [
        start: Main,
        flash_offset: 0x110000
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
      {:exatomvm, github: "bettio/exatomvm", runtime: false}
    ]
  end
end
