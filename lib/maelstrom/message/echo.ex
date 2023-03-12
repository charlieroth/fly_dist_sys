defmodule Maelstrom.Message.Echo.Body do
  @enforce_keys [:msg_id, :echo]
  defstruct [:msg_id, :echo, type: "echo"]
end
