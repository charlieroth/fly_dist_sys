defmodule FlyDistSys.Reader do
  @spec read(pid()) :: :ok
  def read(node) do
    case IO.read(:stdio, :line) do
      :eof ->
        :ok

      {:error, reason} ->
        IO.puts("Error: #{reason}")

      data ->
        Maelstrom.Node.handle(node, data)
        response = Maelstrom.Node.get_response(node)
        IO.write("#{response}\n")
        Maelstrom.Node.flush_response(node)
        read(node)
    end
  end
end
