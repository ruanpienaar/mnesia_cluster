#!/bin/sh
set -x
cd `dirname $0`
erl +A 1 +K true -sname a@localhost -pa $PWD/apps/*/ebin $PWD/_build/default/lib/*/ebin  -setcookie mnesia_cluster -s mnesia_cluster start -config sys.cluster.node.a.config
