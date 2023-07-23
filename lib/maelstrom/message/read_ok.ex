defmodule Maelstrom.Message.ReadOk.Body do
  @moduledoc """
  RPC `read_ok` message 

  In response to a `read` message, it should return this message 
  with a list of values it has seen. The order of the returned values 
  does not matter
  """
  @derive Jason.Encoder
  @enforce_keys [:msg_id, :in_reply_to, :messages, :type]
  defstruct [:msg_id, :in_reply_to, :messages, :type]
end
