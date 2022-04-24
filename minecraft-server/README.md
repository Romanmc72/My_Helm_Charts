# Minecraft Server on k8s

This is to deploy the minecraft server to kubernetes! It has a few requirements, the cluster needs to have a node with at least 3GB free (you can adjust the resource requests/limits and the server resources min/max as well for more or less) and the node you wish to deploy to must be labeled `minecraft-server=true`. Additionally it will need a directory at the root called `/minecraft` in order to save game state on restarts. Then you can launch this as normal with:

```bash
kubectl apply -f minecraft-server.yaml
```

and that is it.

## Editing the Config

The only things you may want to edit are the:

1. location of the saved world data (in case you want to boot an existing world or something)
    - Look at line 82 for that
1. Min/Max memory settings
    - Look at lines 56-66 for that

## NOTE

I tried running this on my in-home cluster and home wifi network with a server running an nginx reverse proxy between the router and the k8s nodes/ports. This DID NOT WORK FOR ME for the bedrock plugin. I tried changing some of the `enable-proxy-*` settings to `true` in the `config.yml` file for the server but it never booted or if it did it didn't work. It did work as a docker image running locally but on k8s, no luck.
