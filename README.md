# Mnesia Cluster

This repo serves as a exploratory exercise with mnesia and a cluster of nodes.

## Running locally

```
$ export NODENAME=node
$ export COOKIE=cookie
$ export MNESIA_DIR=Mnesia
$ make
$ ./_build/default/rel/mnesia_cluster/bin/mnesia_cluster console
```

Cluster nodes are added to kernel's sync_nodes_mandatory property.
mnesia_cluster then runs the mnesia cluster setup on the list of sync_nodes_mandatory nodes.

A list of tables can be specified in config/sys.config, when mnesia_cluster is used as a DEP.