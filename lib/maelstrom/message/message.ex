defmodule Maelstrom.Message do
  @moduledoc """
  A Maelstrom Protocol Message

  https://github.com/jepsen-io/maelstrom/blob/main/doc/protocol.md
  """
  @derive Jason.Encoder
  @enforce_keys [:src, :dest, :body]
  @type t :: %{
          src: String.t(),
          dest: String.t(),
          body: map()
        }
  defstruct [:src, :dest, :body]
end
