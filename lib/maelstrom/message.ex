defmodule Maelstrom.Message do
  alias Maelstrom.Messages

  @spec parse(String.t()) :: %Messages.Init{} | %Messages.Echo{} | nil
  def parse(raw_msg) do
    msg = Jason.decode!(raw_msg)
    body_type = msg |> Map.get("body") |> Map.get("type")

    case body_type do
      "init" ->
        parse_message({:init, msg})

      "echo" ->
        parse_message({:echo, msg})

      _ ->
        IO.puts("Failed to parse message body type")
    end
  end

  def parse_message({:init, msg}) do
    body = Map.get(msg, "body")

    %Messages.Init{
      id: Map.get(msg, "id"),
      src: Map.get(msg, "src"),
      dest: Map.get(msg, "dest"),
      body: %Messages.Init.Body{
        type: Map.get(body, "type"),
        node_id: Map.get(body, "node_id"),
        node_ids: Map.get(body, "node_ids"),
        msg_id: Map.get(body, "msg_id")
      }
    }
  end

  def parse_message({:echo, msg}) do
    msg_body = Map.get(msg, "body")

    %Messages.Echo{
      src: Map.get(msg, "src"),
      dest: Map.get(msg, "des"),
      body: %Messages.Echo.Body{
        type: :echo,
        msg_id: Map.get(msg_body, "msg_id"),
        echo: Map.get(msg_body, "echo")
      }
    }
  end
end
