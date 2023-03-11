defmodule Maelstrom.Messages.EchoOk do
  @derive Jason.Encoder
  @moduledoc """
  Struct representing an `echo_ok` message type
  """
  defstruct [:src, :dest, :body]
end

defmodule Maelstrom.Messages.EchoOk.Body do
  @derive Jason.Encoder
  @moduledoc """
  Struct representing the `body` property of a `echo_ok` message type
  """
  defstruct [:type, :msg_id, :in_reply_to, :echo]
end
