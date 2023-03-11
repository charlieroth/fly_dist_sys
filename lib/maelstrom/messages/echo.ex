defmodule Maelstrom.Messages.Echo do
  @moduledoc """
  Struct representing an `echo` message type
  """
  defstruct [:src, :dest, :body]
end

defmodule Maelstrom.Messages.Echo.Body do
  @moduledoc """
  Struct representing the `body` property of a `echo` message type
  """
  defstruct [:msg_id, :echo, type: :echo]
end
