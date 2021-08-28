# Scoreboard

You have seen this app 3x in my repos. There is one instance in the flask app code standalone, which is referenced as a submodule in my dockerfiles repo, and then finally here. This will manage deploying it on a kubernetes instance somewhere.

## Deploying


~~Just run:~~

~~```helm install scoreboard-app .```~~

~~And that is it. Nothing else is really required. The app uses a redis docker image today that runs in the same k8s cluster as the scoreboard. You can scale up the score board and do some work to use some other redis instance, remove the redis container and change the env vars. I didn't do that but you could do that if you were motivated to do so.~~

I did not write the helm chart yet. Sorry. There are a few `.yaml` files here that you can deploy all together using:

```
kubectl apply \
-f scoreboard-db-deployment.yaml,scoreboard-deployment.yaml,scoreboard-db-service.yaml,scoreboard-service.yaml
```

and that will apply the app to your cluster. The db deeployment can run on any node, just don't scale it up or you will see some weird behavior. The scoreboard web app though can scale to whatever your like. Default is 1 pod. Scale it with:

```
kubectl scale deployment/scoreboard --replicas=#
```

where `#` represents the number of replicas to scale to.

### Caveats

This app is not super secure but also I really don't care. It is just storing scores for scoreboards. Maybe I should care more so convince me.
