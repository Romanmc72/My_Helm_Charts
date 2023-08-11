# Monero Mining in K8s

A lot of this was covered in [the dockerfile repo](https://github.com/Romanmc72/My_Dockerfiles/tree/main/mining/monero/) where I defined these containers. Feel free to check that out. I will not repeat myself here, but instead focus on what the kubernetes setup looks like for the cluster that I am running on.

## This Setup

There are 2 parts to the setup, the `daemon` and the `miner`. The `daemon` is responsible for downloading and synchronizing the blockchain to its own storage. I have a mounted network filesystem running (defined in the [values.yaml](./values.yaml) and the [daemon.yaml](./templates/daemon.yaml)) which is responsible for saving the state of the sync'd blockchain should the container restart or crash for whatever reason. The miner is running on a separate pod/deployment and connects to the daemon via the rpc port defined in the daemon's ClusterIP service. This allows us to run one daemon that can keep the blockchain in sync and then can delegate work to the miners to attempt to mine blocks and earn rewards.

The miners do not have any state/data that is saved on restart, they simply run the mining software and connect to the daemon pod to get blockchain data.