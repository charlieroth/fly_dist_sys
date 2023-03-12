# Fly.io Distributed System Challenges

Solving [Fly.io Distributed System Challenges](https://fly.io/dist-sys/) using Elixir

## Progress

- [X] Challenge 1: Echo
- [ ] Challenge 2: Unique ID Generation
- [ ] Challenge 3: Broadcast
- [ ] Challenge 4: Grow-Only Counter
- [ ] Challenge 5: Kafka-Style Log
- [ ] Challenge 6: Totally-Available Transactions

## Test Messages

`init` message

```json
{"src": "c0", "dest": "n3", "body": {"type": "init", "msg_id": 1, "node_id": "n3", "node_ids": ["n1", "n2", "n3"]}}
```

`generate` message

```json
{"src":"c0", "dest":"n3", "body": {"type": "generate", "msg_id": 2}}
```
