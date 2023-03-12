defmodule Maelstrom.Messages.GenerateOk do
  @moduledoc """
  Struct representing an `echo` message type
  """
  @derive Jason.Encoder
  @enforce_keys [:src, :dest, :body]
  defstruct [:src, :dest, :body]
end

defmodule Maelstrom.Messages.GenerateOk.Body do
  @moduledoc """
  Struct representing the `body` property of a `echo` message type
  """
  @derive Jason.Encoder
  @enforce_keys [:id, :in_reply_to, :type]
  defstruct [:id, :in_reply_to, :type]
end
