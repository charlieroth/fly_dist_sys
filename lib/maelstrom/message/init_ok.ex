defmodule Maelstrom.Message.InitOk.Body do
  @derive Jason.Encoder
  @enforce_keys [:in_reply_to, :msg_id, :type]
  defstruct [:in_reply_to, :msg_id, :type]
end
