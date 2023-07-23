defmodule Maelstrom.Node do
  @moduledoc """
  Represents a maelstrom Node

  Handles incoming messages and sending returning appropriate response structs
  """

  use Agent
  alias Maelstrom.Message
  alias Maelstrom.Message.{
    Init, 
    InitOk, 
    Echo, 
    EchoOk, 
    Generate, 
    GenerateOk,
    Broadcast,
    BroadcastOk,
    Read,
    ReadOk,
    Topology,
    TopologyOk,
  }

  def start_link(_opts) do
    Agent.start_link(fn -> 
      %{
        msg_id: 0,
        id: nil, 
        node_ids: [], 
        messages: [], 
        topology: %{},
      } 
    end)
  end

  def state(node) do
    Agent.get(node, fn state -> state end)
  end

  def handle(node, msg) do
    msg 
    |> Maelstrom.parse() 
    |> handle_message(node)
  end

  def handle_message(%Message{body: %Init.Body{}} = msg, node) do
    Agent.get_and_update(node, fn state ->
      response = %Message{
        id: state.msg_id,
        src: msg.body.node_id,
        dest: msg.src,
        body: %InitOk.Body{
          type: "init_ok",
          msg_id: state.msg_id,
          in_reply_to: msg.body.msg_id
        }
      }

      new_state = %{state | 
        msg_id: state.msg_id + 1,
        id: msg.body.node_id, 
        node_ids: msg.body.node_ids
      }

      {response, new_state}
    end)
  end

  def handle_message(%Message{body: %Echo.Body{}} = msg, node) do
    Agent.get_and_update(node, fn state ->
      response = %Message{
        id: state.msg_id,
        src: state.id,
        dest: msg.src,
        body: %EchoOk.Body{
          type: "echo_ok",
          msg_id: msg.body.msg_id,
          in_reply_to: msg.body.msg_id,
          echo: msg.body.echo
        }
      }
      
      new_state = %{state | msg_id: state.msg_id + 1}

      {response, new_state}
    end)
  end

  def handle_message(%Message{body: %Generate.Body{}} = msg, node) do
    Agent.get_and_update(node, fn state ->
      response = %Message{
        id: state.msg_id,
        src: state.id,
        dest: msg.src,
        body: %GenerateOk.Body{
          type: "generate_ok",
          msg_id: state.msg_id,
          in_reply_to: msg.body.msg_id,
          id: UUID.uuid4(),
        }
      }
      
      new_state = %{state | 
        msg_id: state.msg_id + 1,
      }

      {response, new_state}
    end)
  end
  
  def handle_message(%Message{body: %Broadcast.Body{}} = msg, node) do
    Agent.get_and_update(node, fn state ->
      response = %Message{
        id: state.msg_id,
        src: state.id,
        dest: msg.src,
        body: %BroadcastOk.Body{
          type: "broadcast_ok",
          in_reply_to: msg.id,
          msg_id: state.msg_id,
        }
      }
      
      new_state = %{state | 
        msg_id: state.msg_id + 1,
        messages: [msg.body.message | state.messages]
      }

      {response, new_state}
    end)
  end
  
  def handle_message(%Message{body: %Read.Body{}} = msg, node) do
    Agent.get_and_update(node, fn state ->
      response = %Message{
        id: state.msg_id,
        src: state.id,
        dest: msg.src,
        body: %ReadOk.Body{
          type: "read_ok",
          in_reply_to: msg.id,
          msg_id: state.msg_id,
          messages: state.messages,
        }
      }
      
      new_state = %{state | 
        msg_id: state.msg_id + 1,
      }

      {response, new_state}
    end)
  end
  
  def handle_message(%Message{body: %Topology.Body{}} = msg, node) do
    Agent.get_and_update(node, fn state ->
      response = %Message{
        id: state.msg_id,
        src: state.id,
        dest: msg.src,
        body: %TopologyOk.Body{
          type: "topology_ok",
          in_reply_to: msg.id,
          msg_id: state.msg_id,
        }
      }

      new_state = %{state | 
        msg_id: state.msg_id + 1,
        topology: msg.body.topology[state.id]
      }

      {response, new_state}
    end)
  end
end
