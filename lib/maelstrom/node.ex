defmodule Maelstrom.Node do
  @moduledoc """
  Represents a maelstrom Node

  Handles incoming messages and sending returning appropriate response structs
  """

  use Agent
  alias Maelstrom.Message
  alias Maelstrom.Message.{Init, InitOk, Echo, EchoOk, Generate, GenerateOk}

  def start_link(_opts) do
    Agent.start_link(fn -> %{id: nil, node_ids: []} end)
  end

  def state(node) do
    Agent.get(node, fn state -> state end)
  end

  def handle(node, msg) do
    msg |> Maelstrom.parse() |> handle_message(node)
  end

  def handle_message(%Message{body: %Init.Body{}} = msg, node) do
    Agent.get_and_update(node, fn state ->
      response = %Message{
        src: msg.body.node_id,
        dest: msg.src,
        body: %InitOk.Body{
          in_reply_to: msg.body.msg_id
        }
      }

      new_state = %{state | id: msg.body.node_id, node_ids: msg.body.node_ids}

      {response, new_state}
    end)
  end

  def handle_message(%Message{body: %Echo.Body{}} = msg, node) do
    Agent.get_and_update(node, fn state ->
      response = %Message{
        src: state.id,
        dest: msg.src,
        body: %EchoOk.Body{
          msg_id: msg.body.msg_id,
          in_reply_to: msg.body.msg_id,
          echo: msg.body.echo
        }
      }

      {response, state}
    end)
  end

  def handle_message(%Message{body: %Generate.Body{}} = msg, node) do
    Agent.get_and_update(node, fn state ->
      response = %Message{
        src: state.id,
        dest: msg.src,
        body: %GenerateOk.Body{
          id: UUID.uuid4(),
          in_reply_to: msg.body.msg_id
        }
      }

      {response, state}
    end)
  end
end
