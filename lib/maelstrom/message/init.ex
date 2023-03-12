defmodule Maelstrom.Message.Init.Body do
  @enforce_keys [:node_id, :node_ids, :msg_id]
  defstruct [:node_id, :node_ids, :msg_id, type: "init"]
end
