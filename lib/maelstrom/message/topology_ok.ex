defmodule Maelstrom.Message.TopologyOk.Body do
  @moduledoc """
  RPC `topology_ok` message

  Acknowledgement message in response to receiving a `topology` message
  """

  @derive Jason.Encoder
  @enforce_keys [:msg_id, :in_reply_to, :type]
  defstruct [:msg_id, :in_reply_to, :type]
end
