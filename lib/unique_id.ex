defmodule UniqueId do
  @moduledoc false

  alias FlyDistSys.Reader

  def main(_args) do
    {:ok, node} = Maelstrom.Node.start_link([])
    Reader.read(node)
  end
end
