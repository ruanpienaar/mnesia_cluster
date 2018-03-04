#!/bin/sh
set -x
cd `dirname $0`
erl +A 1 +K true -sname d@localhost -pa $PWD/apps/*/ebin $PWD/_build/default/lib/*/ebin -setcookie mnesia_docker -config sys.cluster.node.a.config
