# tezos-bootstrap

Both containers are sharing the same output directory defined by `TEZOS_DATA_DIR` environment variable.

## how to run
1. Set environment variable `TEZOS_DATA_DIR` so it points to some existing, possibly empty directory on your local machine.
```
mkdir /tmp/bootstrap
export TEZOS_DATA_DIR="/tmp/bootstrap"
``` 

2. Launch tezos-rs node and wait until you see that block are being applied.
```
docker-compose -f docker-compose.rust.yml up
```

3. Stop the tezos-rs node and launch Tezos node.
```
docker-compose -f docker-compose.ocaml.yml up
```

4. Now you should be able to check what is the value of current head.
```
curl http://127.0.0.1:9733/chains/main/blocks/head
```
