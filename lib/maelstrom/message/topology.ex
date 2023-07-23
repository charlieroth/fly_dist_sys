defmodule Maelstrom.Message.Topology.Body do
  @moduledoc """
  RPC `topology` message

  Informs the node of who its neighboring nodes are. All nodes can communicate 
  with each other regardless of the topology passed in

  Example:

  ```
  {
    "type": "topology",
    "topology": {
      "n1": ["n2", "n3"],
      "n2": ["n1"],
      "n3": ["n1"]
    }
  }
  ```
  """

  @derive Jason.Encoder
  @enforce_keys [:topology]
  defstruct [:topology, type: "topology"]
end
