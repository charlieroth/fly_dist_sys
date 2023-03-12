defmodule Maelstrom.Message.EchoOk.Body do
  @derive Jason.Encoder
  @enforce_keys [:msg_id, :in_reply_to, :echo]
  defstruct [:msg_id, :in_reply_to, :echo, type: "echo_ok"]
end
