defmodule Maelstrom.Message do
  @moduledoc """
  A Maelstrom Protocol Message

  https://github.com/jepsen-io/maelstrom/blob/main/doc/protocol.md
  """
  @derive Jason.Encoder
  @enforce_keys [:id, :src, :dest, :body]
  @type t :: %{
          id: integer(),
          src: String.t(),
          dest: String.t(),
          body: map()
        }
  defstruct [:id, :src, :dest, :body]
end
