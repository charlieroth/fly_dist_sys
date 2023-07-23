# Fly.io Distributed System Challenges

Solving [Fly.io Distributed System Challenges](https://fly.io/dist-sys/) using Elixir

## Progress

- [X] Challenge 1: Echo
- [X] Challenge 2: Unique ID Generation
- [ ] Challenge 3: Broadcast
- [ ] Challenge 4: Grow-Only Counter
- [ ] Challenge 5: Kafka-Style Log
- [ ] Challenge 6: Totally-Available Transactions

## Challenge 1: Echo

Compile the project with the `Echo` module as the `main_module:` in the `escript` function in `mix.exs`

```elixir
def escript do
  [main_module: Echo, name: 'echo_bin']
end
```

Run the `maelstrom` test with the `--bin` flag pointing to the compiled binary

```bash
./maelstrom test -w echo --bin ~/path/to/echo_bin --node-count 1 --time-limit 10
```

## Challenge 2: Unqiue ID Generation

Compile the project with the `UniqueId` module as the `main_module:` in the `escript` function in `mix.exs`

```elixir
def escript do
  [main_module: UniqueId, name: 'unique_id_bin']
end
```

Run the `maelstrom` test with the `--bin` flag pointing to the compiled binary

```bash
./maelstrom test -w unique-ids --bin ~/path/to_unique_bin --time-limit 30 --rate 1000 --node-count 3 --availability total --nemesis partition
```

## Challenge 3a: Single-Node Broadcast

Compile the project with the `SingleNodeBroadcast` module as the `main_module:` in the `escript` function in `mix.exs`

```elixir
def escript do
  [main_module: SingleNodeBroadcast, name: 'sn_broadcast_bin']
end
```

Run the `maelstrom` test with the `--bin` flag pointing to the compiled binary

```bash
./maelstrom test -w broadcast --bin ~/path/to/sn_broadcast_bin --node-count 1 --time-limit 20 --rate 10
```

## Example Messages

`init` message

```json
{"id": 0, "src": "c0", "dest": "n1", "body": {"type": "init", "msg_id": 1, "node_id": "n1", "node_ids": ["n1", "n2", "n3"]}}
```

`echo` message

```json
{"id": 1, "src": "c0", "dest": "n1", "body": {"type": "echo", "msg_id": 1, "echo": "Please echo 42"}}
```

`generate` message

```json
{"id": 2, "src":"c0", "dest":"n1", "body": {"type": "generate", "msg_id": 2}}
```

`broadcast` message

```json
{"id": 3, "src": "c0", "dest": "n1", "body": {"type": "broadcast", "message": 1000}}
```

`read` message

```json
{"id": 4, "src": "c0", "dest": "n1", "body": {"type": "read"}}
```

`topology` message

```json
{"id": 5, "src": "c0", "dest": "n1", "body": {"type": "topology", "topology": {"n1": ["n2", "n3"], "n2": ["n1"], "n3": ["n1"]}}}
```

### iex testing

```
iex(1)> {:ok, node} = Maelstrom.Node.start_link([])
iex(2)> node |> Maelstrom.Node.handle("{\"id\": 0, \"src\": \"c0\", \"dest\": \"n1\", \"body\": {\"type\": \"init\", \"msg_id\": 1, \"node_id\": \"n1\", \"node_ids\": [\"n1\", \"n2\", \"n3\"]}}")
iex(3)> node |> Maelstrom.Node.state()
iex(4)> node |> Maelstrom.Node.handle("{\"id\": 5, \"src\": \"c0\", \"dest\": \"n0\", \"body\": {\"type\": \"topology\", \"topology\": {\"n0\": [\"n1\", \"n2\"], \"n1\": [\"n2\"], \"n2\": [\"n0\"]}}}")
iex(5)> node |> Maelstrom.Node.state()
iex(6)> node |> Maelstrom.Node.handle("{\"id\": 3, \"src\": \"c0\", \"dest\": \"n1\", \"body\": {\"type\": \"broadcast\", \"message\": 1000}}")
iex(7)> node |> Maelstrom.Node.state()
iex(8)> node |> Maelstrom.Node.handle("{\"id\": 3, \"src\": \"c0\", \"dest\": \"n1\", \"body\": {\"type\": \"broadcast\", \"message\": 1010}}")
iex(9)> node |> Maelstrom.Node.state()
iex(10)> node |> Maelstrom.Node.handle("{\"id\": 4, \"src\": \"c0\", \"dest\": \"n1\", \"body\": {\"type\": \"read\"}}")
```

