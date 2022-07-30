# k8s-manifests

A collection fo Kubernetes manifests

## Synapse

Deploys a [Synapse server](https://github.com/matrix-org/synapse) and a Postgresql database in a bare-metal cluster

Notes:
* homeserver.yaml is encrypted (`server-sealed-secrets.yaml`) using Bitnami's `sealed-secrets` controller as it contains database credentials
* as it is a bare-metal cluster, we use `openebs` to provide with storage. The storage class used is `openebs-jiva-csi-sc`
* for networking, we have an Nginx ingress controller - bound to the VMs' host network - that reads the rule of `server-ingress.yaml` and route traffic to the server (Nginx ingress controller -> ingress -> service -> synapse server)
* for federation, we cannot use port 8448 with the ingress controller, so we leverage delegation (see `nginx.ingress.kubernetes.io/configuration-snippet` in `server-ingress.yaml`)