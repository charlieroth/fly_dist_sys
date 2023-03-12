defmodule Maelstrom.Message.InitOk.Body do
  @derive Jason.Encoder
  @enforce_keys [:in_reply_to]
  defstruct [:in_reply_to, type: "init_ok"]
end
