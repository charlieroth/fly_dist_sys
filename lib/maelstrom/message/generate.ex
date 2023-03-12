defmodule Maelstrom.Message.Generate.Body do
  @derive Jason.Encoder
  @enforce_keys [:msg_id]
  defstruct [:msg_id, type: "generate"]
end
