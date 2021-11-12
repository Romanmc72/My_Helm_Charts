# PI-Hole

**Shut Your Pi-Hole!** Just kidding, this is a raspberry pi-based application that I am running in a container on Kubernetes. The whole point is to be able to have more control over your in-home network. You can do things like block all traffic from certain advertisers, create your own DNS service, set up your own DHCP service, etc. "Blah Blah Blah internet tech jargon I get it, you're a nerd". Basically what I wanted to do with it is set up a way for my website [r0m4n.com](https://r0m4n.com) to be reachable from inside of my home wifi instead of only outside of it. I mean it *is* technically reachable but you have to either visit the IP address of the box it runs on or the local hostname for that machine which is not a great experience for folks just trying to use the service while they're at my place. So! With this I hope I can set these things up without any hassle and get them running pretty quickly. I will be deploying it with a simple `yaml` file, no helm config for now.

## Launching it

You ideally will just:
- deploy the yaml to the cluster
- configure your router to use the cluster as the DNS and DHCP service
- configure the pi-hole through the web interface
- profit!

## Other things

I bought a motorola router to evade rental prices for the cable company, so I will probably have the router configuration file checked in here as well as the pi-hole configs if there are any.

## What is here?

There is an `./up.sh` script to run pihole locally, but it will not deploy it to kubernetes for you. Then there is the k8s deployment and service file.

## Using this

You will want to have a secrets file to deploy along with this. I excluded it for what I hope are obvious reasons. Here is an example:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: pi-hole-secrets
  namespace: default
type: Opaque
data:
  webpassword: <your-base64-encoded-secret-string>
```

Once that is up on the cluster you just need to ensure that the ports that the kubernetes service exposes are correctly being routed by nginx or whatever you are using to forward udp and tcp traffic for DNS lookups. You will need to distinguish the two because you will get a different port for each. I did that in my `/etc/nginx/nginx.conf` file like so:

```nginx
stream {
	server {
        	listen 53 udp;
        	proxy_pass 0.0.0.0:32224;
	}

	server {
        	listen 53 tcp;
        	proxy_pass 0.0.0.0:31781;
	}

}
```

Then restart nginx or whatever it is you are doing.

Also for DNS to work, the server running this must be the only DNS server that your router uses. You cannot have a secondary one otherwise that one (if it responds faster) will take precedence.
