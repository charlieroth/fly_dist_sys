defmodule Maelstrom do
  alias Maelstrom.Message
  alias Maelstrom.Message.{Init, Echo, Generate}

  @spec parse(String.t()) :: %Message{} | :ok
  def parse(raw_msg) do
    msg = raw_msg |> Jason.decode!()
    type = msg |> Map.get("body") |> Map.get("type")
    parse_message(type, msg)
  end

  def parse_message("init", msg) do
    %Message{
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

  def parse_message("echo", msg) do
    %Message{
      src: msg |> Map.get("src"),
      dest: msg |> Map.get("dest"),
      body: %Echo.Body{
        msg_id: msg |> Map.get("body") |> Map.get("msg_id"),
        echo: msg |> Map.get("body") |> Map.get("echo")
      }
    }
  end

  def parse_message("generate", msg) do
    %Message{
      src: msg |> Map.get("src"),
      dest: msg |> Map.get("dest"),
      body: %Generate.Body{
        msg_id: msg |> Map.get("body") |> Map.get("msg_id")
      }
    }
  end

  def parse_message(type, _msg) do
    IO.puts("Unsupported message type: #{type}")
  end
end
