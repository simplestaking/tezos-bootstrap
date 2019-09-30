#!/bin/sh

run_rust() {
    # launch docker-compose
    docker-compose -f docker-compose.rust.yml pull &&
    docker-compose -f docker-compose.rust.yml up
}

run_ocaml() {
  # launch docker-compose
    docker-compose -f docker-compose.ocaml.yml pull &&
    docker-compose -f docker-compose.ocaml.yml up
}


#  cli
while :; do
  case $1 in

    -r|--bootsrap-from-rust)
        echo "\033[1;37mBootstrap Tezos node from Rust\e[0m\n";
        run_rust
        ;;

    -o|--run-from-ocaml)
        echo "\033[1;37mRun OCaml node\e[0m\n";
        run_rust
        ;;

    -h|--help)
        echo "Usage:"
        echo "run.sh [OPTION]\n"
        echo "Set of tools for bootsraping Tezos node  \n"
        echo " -r,  --bootsrap-from-rust  bootstrap Tezos node from Rust"
        echo " -o,  --run-from-ocaml      run Tezos node"
        exit 0
        ;;
    
    --)              
        shift
        break   
        ;;

    -?*)
        printf 'Unknown option: %s\n' "$1" >&2
        echo "(run $0 -h for help)\n"
        ;;
  
    ?*)
        echo "Missing option"
        echo "(run $0 -h for help)\n"
        ;;
  
    *)
        break
    
    esac

    shift
done