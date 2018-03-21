.PHONY: release compile get-deps test clean dialyzer rebar3

release: compile
	@./rebar3 release

compile: rebar3 get-deps
	@./rebar3 compile

get-deps:
	@./rebar3 get-deps

test:
	@./rebar3 eunit ct

clean:
	@./rebar3 clean

dialyzer: compile
	@./rebar3 dialyzer

rebar3:
	@ls rebar3 || wget https://s3.amazonaws.com/rebar3/rebar3 && chmod +x rebar3
	
console:
	@export RELX_REPLACE_OS_VARS=true
	@export NODE_NAME="node_name@127.0.0.1"
	@export COOKIE="cookie"
	@./_build/default/rel/mnesia_docker/bin/mnesia_docker console