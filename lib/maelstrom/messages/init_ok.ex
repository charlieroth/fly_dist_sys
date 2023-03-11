defmodule Maelstrom.Messages.InitOk do
  @derive Jason.Encoder
  @moduledoc """
  Struct representing an `init_ok` message type

  In response to the `init` message, each node must respond with a message
  of type `init_ok`.

  Example message:
  ```json
  {
    "type": "init_ok",
    "in_reply_to": 1
  }
  ```
  """
  defstruct [:src, :dest, :body]
end

defmodule Maelstrom.Messages.InitOk.Body do
  @derive Jason.Encoder
  @moduledoc """
  Struct representing an `init_ok` `body` property
  """
  defstruct [:type, :in_reply_to]
end
