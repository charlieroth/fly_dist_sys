defmodule Maelstrom.Message.Read.Body do
  @moduledoc """
  RPC `read` message 

  This message requests that a node return all values that it has seen
  """ 
  @derive Jason.Encoder
  @enforce_keys [:msg_id]
  defstruct [:msg_id, type: "read"]
end
