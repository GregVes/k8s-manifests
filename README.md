# k8s-manifests

A collection fo Kubernetes manifests. Any change in an app's manifest files triggers a deployment handled by `argocd.gregentoo-cluster.eu` instance.

## Synapse

Deploys a [Synapse server](https://github.com/matrix-org/synapse) and a Postgresql database in a bare-metal cluster

Notes:
* homeserver.yaml is encrypted (`server-sealed-secrets.yaml`) using Bitnami's `sealed-secrets` controller as it contains database credentials
* as it is a bare-metal cluster, we use `openebs` to provide with storage. The storage class used is `openebs-jiva-csi-sc`
* for networking, we have an Nginx ingress controller - bound to the VMs' host network - that reads the rule of `server-ingress.yaml` and route traffic to the server (Nginx ingress controller -> ingress -> service -> synapse server)
* for federation, we cannot use port 8448 with the ingress controller, so we leverage delegation (see `nginx.ingress.kubernetes.io/configuration-snippet` in `server-ingress.yaml`)
* a CronJob backs up the db to AWS s3 every day at midnight using [this](https://github.com/GregVes/docker-images/tree/main/pgdump-s3) Docker image
