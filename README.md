# tezos-bootstrap

Both containers are sharing the same output directory defined by `TEZOS_DATA_DIR` environment variable.

## how to run
- Set environment variable `TEZOS_DATA_DIR` so it points to some existing, possibly empty directory on your local machine.
```
# export TEZOS_DATA_DIR="/tmp/bootstrap"
# mkdir -p "$TEZOS_DATA_DIR" "$TEZOS_DATA_DIR/tezos-rs-data"
``` 
- Start OCaml tezos node to perform initialization. Wait until the identity and the storage are generated. Then stop the
  the node by pressing `ctrl-c`.
```
# docker-compose -f docker-compose.ocaml.yml up
alphanet_1  | Current public chain: 2018-11-30T15:30:56Z-alphanet.
alphanet_1  | Local chain data: 2018-11-30T15:30:56Z-alphanet.
alphanet_1  | Updating the node configuration...
alphanet_1  | Sep 30 10:07:19 - node.main: Starting the Tezos node...
alphanet_1  | Sep 30 10:07:19 - node.main: No local peer discovery.
alphanet_1  | Sep 30 10:07:19 - node.main: Peer's global id: idsZe3q3cM5uPxfxjk3MnvcMpjD28G
alphanet_1  | Sep 30 10:07:19 - main: shell-node initialization: bootstrapping
alphanet_1  | Sep 30 10:07:19 - main: shell-node initialization: p2p_maintain_started
alphanet_1  | Sep 30 10:07:19 - main: validator-block : Worker started(2019-09-30T10:07:19-00:00)
alphanet_1  | Sep 30 10:07:19 - validation_process.sequential: Initialized
alphanet_1  | Sep 30 10:07:19 - node.validator: activate chain NetXgtSLGNJvNye
alphanet_1  | Sep 30 10:07:19 - p2p.maintenance: Too few connections (0)
alphanet_1  | Sep 30 10:07:19 - main: validator-chain_1 : Worker started for NetXgtSLGNJvN(2019-09-30T10:07:19-00:00)
alphanet_1  | Sep 30 10:07:19 - node.chain_validator: no prevalidator filter found for protocol 'Ps6mwMrF2ER2'
ctrl-c
```

- Now launch the tezos-rs node and wait until you see that block are being applied.
```
# docker-compose -f docker-compose.rust.yml up
..
tezos-rs-node_1  | 2019-09-30 10:02:20+00:00 INFO [shell::chain_feeder] Applying block BMPtRJqFGQJRTfn8bXQR2grLE1M97XnUmG5vgjHMW7St1Wub7Cd
tezos-rs-node_1  | 2019-09-30 10:02:23+00:00 INFO [shell::chain_feeder] Applying block BLwKksYwrxt39exDei7yi47h7aMcVY2kZMZhTwEEoSUwToQUiDV
tezos-rs-node_1  | 2019-09-30 10:02:23+00:00 INFO [shell::chain_feeder] Applying block BLTQ5B4T4Tyzqfm3Yfwi26WmdQScr6UXVSE9du6N71LYjgSwbtc
ctrl-c
```
- Move data created by the tezos-rs node to the OCaml tezos node data directory. Launch the OCaml tezos node again.

```
# sudo cp -r "$TEZOS_DATA_DIR/tezos-rs-data/." "$TEZOS_DATA_DIR/data/"
# docker-compose -f docker-compose.ocaml.yml up
```

- Now you should be able to check the updated value of current head.
```
# curl http://127.0.0.1:8732/chains/main/blocks/head | jq
```
