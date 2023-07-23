defmodule Maelstrom.Message.GenerateOk.Body do
  @derive Jason.Encoder
  @enforce_keys [:id, :in_reply_to, :msg_id, :type]
  defstruct [:id, :in_reply_to, :msg_id, :type]
end
