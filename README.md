# node-docker-devenv
A dockerfile for building a ubuntu based image for nodejs developement

build :
docker build -t node_devenv .

run :
./run_node_devenv.sh /path/to/git/repo/

connect :
ssh -X -p 6000 root@localhost
