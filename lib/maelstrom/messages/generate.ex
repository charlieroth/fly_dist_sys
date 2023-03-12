defmodule Maelstrom.Messages.Generate do
  @moduledoc """
  Struct representing an `echo` message type
  """

  @derive Jason.Encoder
  @enforce_keys [:src, :dest, :body]
  defstruct [:src, :dest, :body]
end

defmodule Maelstrom.Messages.Generate.Body do
  @moduledoc """
  Struct representing the `body` property of a `echo` message type
  """

  @derive Jason.Encoder
  @enforce_keys [:msg_id, :type]
  defstruct [:msg_id, :type]
end
