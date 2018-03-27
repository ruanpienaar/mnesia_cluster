#!/bin/sh
cd `dirname $0`
HN=localhost
erl +A 1 +K true -sname a@$HN -pa $PWD/apps/*/ebin $PWD/_build/default/lib/*/ebin  -setcookie mnesia_cluster -s mnesia_cluster start -config sys.cluster.node.a.config -detached -noinput -noshell -mnesia dir "'"$PWD"/a/Mnesia'"
erl +A 1 +K true -sname b@$HN -pa $PWD/apps/*/ebin $PWD/_build/default/lib/*/ebin  -setcookie mnesia_cluster -s mnesia_cluster start -config sys.cluster.node.b.config -detached -noinput -noshell -mnesia dir "'"$PWD"/b/Mnesia'"
erl +A 1 +K true -sname c@$HN -pa $PWD/apps/*/ebin $PWD/_build/default/lib/*/ebin  -setcookie mnesia_cluster -s mnesia_cluster start -config sys.cluster.node.c.config -detached -noinput -noshell -mnesia dir "'"$PWD"/c/Mnesia'"
echo "3 nodes started ..."
echo "maintenance shell commands:"
echo "erl -sname maint_a@$HN -setcookie mnesia_cluster -remsh a@$HN -hidden"
echo "erl -sname maint_b@$HN -setcookie mnesia_cluster -remsh b@$HN -hidden"
echo "erl -sname maint_c@$HN -setcookie mnesia_cluster -remsh c@$HN -hidden"