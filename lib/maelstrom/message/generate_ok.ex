defmodule Maelstrom.Message.GenerateOk.Body do
  @derive Jason.Encoder
  @enforce_keys [:id, :in_reply_to]
  defstruct [:id, :in_reply_to, type: "generate_ok"]
end
