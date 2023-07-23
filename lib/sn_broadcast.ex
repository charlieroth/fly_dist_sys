defmodule SingleNodeBroadcast do
  @moduledoc """
  SingleNodeBroadcast module for Challenge #3a
  """
  
  alias Maelstrom.Node

  def main(_args) do
    {:ok, node} = Node.start_link([])
    read(node)
  end

  def read(node) do
    case IO.read(:stdio, :line) do
      :eof ->
        :ok

      {:error, reason} ->
        IO.puts("Error: #{reason}")

      request ->
        IO.puts(:stderr, "request: #{request}")
        response =
          node
          |> Node.handle(request)
          |> Jason.encode!()

        node_state = node |> Node.state() |> Jason.encode!()
        IO.puts(:stderr, "node: #{node_state}")
        IO.puts(:stderr, "response: #{response}")
        IO.write("#{response}\n")
        read(node)
    end
  end
end
