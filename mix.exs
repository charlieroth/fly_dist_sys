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
      extra_applications: [:logger, :crypto],
      mod: {FlyDistSys.Application, []}
    ]
  end

  def escript do
    # [main_module: Echo, name: 'echo_bin']
    # [main_module: UniqueId, name: 'unique_id_bin']
    [main_module: SingleNodeBroadcast, name: 'sn_broadcast_bin']
    # [main_module: MultiNodeBroadcast, name: 'mn_broadcast_bin']
    # [main_module: GrowOnlyCounter, name: 'grow_only_counter_bin']
    # [main_module: KafkaLog, name: 'kafka_log_bin']
    # [main_module: KV, name: 'kv_bin']
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.4"},
      {:uuid, "~> 1.1"}
    ]
  end
end
