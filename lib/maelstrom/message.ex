defmodule Maelstrom.Message do
  alias Maelstrom.Messages.{Init, Echo, Generate}

  @spec parse(String.t()) :: %Init{} | %Echo{} | %Generate{} | :ok
  def parse(raw_msg) do
    msg = raw_msg |> Jason.decode!()
    type = msg |> Map.get("body") |> Map.get("type")

    case type do
      "init" ->
        parse_message({:init, msg})

      "echo" ->
        parse_message({:echo, msg})

      "generate" ->
        parse_message({:generate, msg})

      t ->
        IO.puts("Unsupported message type: #{t}")
    end
  end

  def parse_message({:init, msg}) do
    %Init{
      id: msg |> Map.get("id"),
      src: msg |> Map.get("src"),
      dest: msg |> Map.get("dest"),
      body: %Init.Body{
        type: msg |> Map.get("body") |> Map.get("type"),
        msg_id: msg |> Map.get("body") |> Map.get("msg_id"),
        node_id: msg |> Map.get("body") |> Map.get("node_id"),
        node_ids: msg |> Map.get("body") |> Map.get("node_ids")
      }
    }
  end

  def parse_message({:echo, msg}) do
    %Echo{
      src: msg |> Map.get("src"),
      dest: msg |> Map.get("dest"),
      body: %Echo.Body{
        type: "echo",
        msg_id: msg |> Map.get("body") |> Map.get("msg_id"),
        echo: msg |> Map.get("body") |> Map.get("echo")
      }
    }
  end

  def parse_message({:generate, msg}) do
    %Generate{
      src: msg |> Map.get("src"),
      dest: msg |> Map.get("dest"),
      body: %Generate.Body{
        type: "generate",
        msg_id: msg |> Map.get("body") |> Map.get("msg_id")
      }
    }
  end
end
