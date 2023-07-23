defmodule Maelstrom.Message.EchoOk.Body do
  @derive Jason.Encoder
  @enforce_keys [:msg_id, :in_reply_to, :echo, :type]
  defstruct [:msg_id, :in_reply_to, :echo, :type]
end
