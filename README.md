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

## Example Messages

`init` message

```json
{"src": "c0", "dest": "n3", "body": {"type": "init", "msg_id": 1, "node_id": "n3", "node_ids": ["n1", "n2", "n3"]}}
```

`echo` message

```json
{"src": "c0", "dest": "n3", "body": {"type": "echo", "msg_id": 1, "echo": "Please echo 42"}}
```

`generate` message

```json
{"src":"c0", "dest":"n3", "body": {"type": "generate", "msg_id": 2}}
```
