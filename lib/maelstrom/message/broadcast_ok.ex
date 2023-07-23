defmodule Maelstrom.Message.BroadcastOk.Body do
  @moduledoc """
  RPC `broadcast_ok` message 

  In response to `broadcast` messages, it should send an acknowledgement, this
  message
  """ 
  @derive Jason.Encoder
  @enforce_keys [:msg_id, :in_reply_to, :type]
  defstruct [:msg_id, :in_reply_to, :type]
end
