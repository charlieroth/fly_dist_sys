defmodule Maelstrom.Message.Broadcast.Body do
  @moduledoc """
  RPC `broadcast` message 

  This message requests that a value be broadcast out to all nodes in the 
  cluster. The value is always an integer and it is unique for each message 
  from Maelstrom.

  It should store the "message" value locally so it can be read later
  """ 
  @derive Jason.Encoder
  @enforce_keys [:message, :msg_id]
  defstruct [:message, :msg_id, type: "broadcast"]
end
