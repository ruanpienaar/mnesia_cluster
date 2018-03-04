#!/bin/sh
set -x
cd `dirname $0`
erl +A 1 +K true -sname c@localhost -pa $PWD/apps/*/ebin $PWD/_build/default/lib/*/ebin  -setcookie mnesia_docker -s mnesia_docker start -config sys.cluster.node.c.config