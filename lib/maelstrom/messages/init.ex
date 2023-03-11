defmodule Maelstrom.Messages.Init do
  @moduledoc """
  Struct representing an `init` message type

  Example message:
  ```json
  {
    "id": 0,
    "src": "c0",
    "dest": "n0",
    "body": {
      "type": "init",
      "node_id": "n0",
      "node_ids": ["n0"],
      "msg_id": 1
    }
  }
  ```

  The `node_id` field indicates the ID of the node which is receiving this
  message: here, the node ID is `"n1"`. Your node should remember this ID
  and include it as the `src` of any message it sends.

  The `node_ids` field lists all nodes in the cluster, including the recipient.
  All nodes receive an identical list; you may use its order if you like.
  """
  defstruct [:id, :src, :dest, :body]
end

defmodule Maelstrom.Messages.Init.Body do
  defstruct [:type, :node_id, :node_ids, :msg_id]
end
