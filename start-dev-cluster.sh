#!/bin/sh
#set -x
cd `dirname $0`
# HN=`hostname`
HN=localhost
#mkdir a
#mkdir b
#mkdir c
erl +A 1 +K true -sname a@$HN -pa $PWD/apps/*/ebin $PWD/_build/default/lib/*/ebin  -setcookie mnesia_docker -s mnesia_docker start -config sys.cluster.node.a.config -detached -noinput -noshell
erl +A 1 +K true -sname b@$HN -pa $PWD/apps/*/ebin $PWD/_build/default/lib/*/ebin  -setcookie mnesia_docker -s mnesia_docker start -config sys.cluster.node.b.config -detached -noinput -noshell
erl +A 1 +K true -sname c@$HN -pa $PWD/apps/*/ebin $PWD/_build/default/lib/*/ebin  -setcookie mnesia_docker -s mnesia_docker start -config sys.cluster.node.c.config -detached -noinput -noshell

echo "3 nodes started ..."
echo "maintenance shell commands:"
echo "erl -sname maint_a@$HN -setcookie mnesia_docker -remsh a@$HN -hidden"
echo "erl -sname maint_b@$HN -setcookie mnesia_docker -remsh b@$HN -hidden"
echo "erl -sname maint_c@$HN -setcookie mnesia_docker -remsh c@$HN -hidden"