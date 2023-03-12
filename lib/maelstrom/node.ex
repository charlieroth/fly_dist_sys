defmodule Maelstrom.Node do
  use Agent
  alias Maelstrom.Message
  alias Maelstrom.Message.{Init, InitOk, Echo, EchoOk, Generate, GenerateOk}

  def start_link(_opts) do
    Agent.start_link(fn -> %{id: nil, node_ids: []} end)
  end

  def state(node) do
    Agent.get(node, fn state -> state end)
  end

  def handle(node, data) do
    case Maelstrom.parse(data) do
      %Message{body: %Init.Body{}} = msg ->
        Agent.get_and_update(node, fn state ->
          body = msg |> handle_message()

          {%Message{src: msg.body.node_id, dest: msg.src, body: body},
           %{state | id: msg.body.node_id, node_ids: msg.body.node_ids}}
        end)

      %Message{body: %Echo.Body{}} = msg ->
        Agent.get_and_update(node, fn state ->
          body = msg |> handle_message()
          {%Message{src: state.id, dest: msg.src, body: body}, state}
        end)

      %Message{body: %Generate.Body{}} = msg ->
        Agent.get_and_update(node, fn state ->
          body = msg |> handle_message()
          {%Message{src: state.id, dest: msg.src, body: body}, state}
        end)
    end
  end

  def handle_message(%Message{body: %Init.Body{}} = msg) do
    %InitOk.Body{
      in_reply_to: msg.body.msg_id
    }
  end

  def handle_message(%Message{body: %Echo.Body{}} = msg) do
    %EchoOk.Body{
      msg_id: msg.body.msg_id,
      in_reply_to: msg.body.msg_id,
      echo: msg.body.echo
    }
  end

  def handle_message(%Message{body: %Generate.Body{}} = msg) do
    %GenerateOk.Body{
      id: UUID.uuid4(),
      in_reply_to: msg.body.msg_id
    }
  end
end
