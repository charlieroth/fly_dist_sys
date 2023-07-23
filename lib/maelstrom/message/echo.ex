defmodule Maelstrom.Message.Echo.Body do
  @enforce_keys [:msg_id, :echo, :type]
  defstruct [:msg_id, :echo, :type]
end
