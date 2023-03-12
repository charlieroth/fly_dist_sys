defmodule UniqueId do
  @moduledoc """
  UniqueId module for Challenge #2
  """

  alias Maelstrom.Node

  def main(_args) do
    {:ok, node} = Maelstrom.Node.start_link([])
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
