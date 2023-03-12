defmodule Maelstrom.Message do
  @derive Jason.Encoder
  @enforce_keys [:src, :dest, :body]
  defstruct [:src, :dest, :body]
end
