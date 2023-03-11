defmodule Maelstrom.Node do
  use Agent
  alias Maelstrom.Messages.{Init, InitOk, Echo, EchoOk}

  def start_link(_opts) do
    Agent.start_link(fn ->
      %{id: nil, node_ids: [], msg_id: 0, response: nil}
    end)
  end

  def state(node) do
    Agent.get(node, fn state -> state end)
  end

  def get_response(node) do
    Agent.get(node, fn state -> state.response end)
  end

  def flush_response(node) do
    Agent.update(node, fn state -> %{state | response: nil} end)
  end

  def handle(node, data) do
    case Maelstrom.Message.parse(data) do
      %Init{} = msg ->
        Agent.update(node, fn state -> handle_message(msg, state) end)

      %Echo{} = msg ->
        Agent.update(node, fn state -> handle_message(msg, state) end)
    end
  end

  def handle_message(%Init{} = msg, state) do
    response =
      %InitOk{
        src: msg.body.node_id,
        dest: msg.src,
        body: %InitOk.Body{
          type: "init_ok",
          in_reply_to: msg.body.msg_id
        }
      }
      |> Jason.encode!()

    %{
      state
      | id: msg.body.node_id,
        node_ids: msg.body.node_ids,
        response: response
    }
  end

  def handle_message(%Echo{} = msg, state) do
    response =
      %EchoOk{
        src: state.id,
        dest: msg.src,
        body: %EchoOk.Body{
          type: "echo_ok",
          msg_id: state.msg_id,
          in_reply_to: msg.body.msg_id,
          echo: msg.body.echo
        }
      }
      |> Jason.encode!()

    %{state | response: response, msg_id: state.msg_id + 1}
  end
end
