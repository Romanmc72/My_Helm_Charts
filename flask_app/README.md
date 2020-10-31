# flask_app Helm Chart
This is the flask app that I install to run my website either locally on minikube or in production on my in-home cluster.

## Using these charts
Take a look at the `example.values.yaml` file, and copy that to a `values.yaml` file. Fill in the parts surrounded by carats `<>`. Then create 2 secrets files as laid out by the comments in the bottom of the file.

After you have filled everything in, and assuming that you have `helm` and `kubectl` already installed as well as your `kubectl` is pointing to a valid k8s cluster that you have the correct permissions to manipulate, you just need to run:

```bash
helm install flask-application .
kubectl apply ./secret-file-1.yaml
kubectl apply ./secret-file-2.yaml
```

and the cluster should be up and running in no time!

# Oh wait, I forgot to mention...
This application requires a few other things in order to launch:
1. A single node k8s cluster (I know, yuck)
2. on that single node, you have my [flask application code](https://github.com/Romanmc72/flask_app) cloned to /host/flask_app
3. you have a directory created for the postgres container to write to at `/var/lib/postgresql/data/`

okay that is it, then it certainly should work :)