#!/bin/sh
set -x
if [ "$#" == "1" ]; then
    cd `dirname $0`
    erl +A 1 +K true -sname $1@localhost -pa $PWD/apps/*/ebin $PWD/_build/default/lib/*/ebin  -setcookie mnesia_docker -config sys.config
    #-mnesia dir "'"$PWD"/Mnesia'"
fi
