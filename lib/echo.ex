defmodule Echo do
  @moduledoc """
  Echo module for Challenge #1
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

      data ->
        response =
          node
          |> Node.handle(data)
          |> Jason.encode!()

        IO.write("#{response}\n")
        read(node)
    end
  end
end
